import 'package:dartz/dartz.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';
import 'package:husbandman/src/auth/domain/use-cases/authenticate_reset_password_token.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'auth_repo.mock.dart';

void main() {
  late AuthRepo authRepo;
  late AuthenticateResetPasswordToken usecase;

  const tToken = 'token';

  setUp(() {
    authRepo = MockAuthRepo();
    usecase = AuthenticateResetPasswordToken(authRepo);
  });

  group('Authenticate Reset Password Token', () {
    test('Should return [Right(bool)] when successful', () async {
      when(() => authRepo.authenticateResetPasswordToken(token: tToken))
          .thenAnswer((_) async => const Right(true));

      final result = await usecase(tToken);

      expect(result, equals(const Right<dynamic, bool>(true)));

      verify(() => authRepo.authenticateResetPasswordToken(token: tToken))
          .called(1);
      verifyNoMoreInteractions(authRepo);
    });

    test('Should return [Left(ServerFailure)] when unsuccessful', () async {
      when(() => authRepo.authenticateResetPasswordToken(token: tToken))
          .thenAnswer(
        (_) async => Left(
          ServerFailure(
              message: 'Token authentication failed', statusCode: 401),
        ),
      );

      final result = await usecase(tToken);

      expect(
        result,
        equals(
          Left<ServerFailure, dynamic>(
            ServerFailure(
              message: 'Token authentication failed',
              statusCode: 401,
            ),
          ),
        ),
      );

      verify(() => authRepo.authenticateResetPasswordToken(token: tToken))
          .called(1);
      verifyNoMoreInteractions(authRepo);
    });
  });
}
