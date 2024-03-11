import 'package:dartz/dartz.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';
import 'package:husbandman/src/auth/domain/use-cases/authenticate_reset_password_token.dart';
import 'package:husbandman/src/auth/domain/use-cases/reset_password.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'auth_repo.mock.dart';

void main() {
  late AuthRepo authRepo;
  late ResetPassword usecase;

  const tNewPassword = 'new-password';

  setUp(() {
    authRepo = MockAuthRepo();
    usecase = ResetPassword(authRepo);
  });

  group('Reset Password', () {
    test('Should return [Right(void)] when successful', () async {
      when(() => authRepo.resetPassword(newPassword: tNewPassword))
          .thenAnswer((_) async => const Right(null));

      final result = await usecase(tNewPassword);

      expect(result, equals(const Right<dynamic, void>(null)));

      verify(() => authRepo.resetPassword(newPassword: tNewPassword))
          .called(1);
      verifyNoMoreInteractions(authRepo);
    });

    test('Should return [Left(ServerFailure)] when unsuccessful', () async {
      when(() => authRepo.resetPassword(newPassword: tNewPassword)).thenAnswer(
        (_) async => Left(
          ServerFailure(
            message: 'Password changed too many times. Try again next month',
            statusCode: 400,
          ),
        ),
      );

      final result = await usecase(tNewPassword);

      expect(
        result,
        equals(
          Left<ServerFailure, dynamic>(
            ServerFailure(
              message: 'Password changed too many times. Try again next month',
              statusCode: 400,
            ),
          ),
        ),
      );

      verify(() => authRepo.resetPassword(newPassword: tNewPassword))
          .called(1);
      verifyNoMoreInteractions(authRepo);
    });
  });
}
