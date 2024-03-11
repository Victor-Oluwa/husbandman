import 'package:dartz/dartz.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';
import 'package:husbandman/src/auth/domain/use-cases/send_reset_password_token.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'auth_repo.mock.dart';

void main() {
  late AuthRepo authRepo;
  late SendResetPasswordToken usecase;

  const testEmail = 'brainfoster@gmail.com';

  setUp(() {
    authRepo = MockAuthRepo();
    usecase = SendResetPasswordToken(authRepo);
  });

  group('ForgotPassword', () {
    test('Should return Right(void) when successful', () async {
      when(
        () => authRepo.sendResetPasswordToken(
          email: any(named: 'email'),
        ),
      ).thenAnswer((_) async => const Right(null));

      final result = await usecase(testEmail);

      expect(result, equals(const Right<dynamic, void>(null)));

      verify(() => authRepo.sendResetPasswordToken(email: testEmail)).called(1);
      verifyNoMoreInteractions(authRepo);
    });

    test('Should return Left(ServerFailure) when unsuccessful', () async {
      when(
        () => authRepo.sendResetPasswordToken(
          email: any(named: 'email'),
        ),
      ).thenAnswer(
        (_) async => Left(
          ServerFailure(
            message: 'The provided email does not belong to an account',
            statusCode: 401,
          ),
        ),
      );

      final result = await usecase(testEmail);

      expect(
        result,
        equals(
          Left<ServerFailure, dynamic>(ServerFailure(
            message: 'The provided email does not belong to an account',
            statusCode: 401,
          )),
        ),
      );

      verify(()=> authRepo.sendResetPasswordToken(email: testEmail)).called(1);
      verifyNoMoreInteractions(authRepo);
    });
  });
}
