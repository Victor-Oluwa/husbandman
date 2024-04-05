import 'package:dartz/dartz.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/auth/domain/entity/user_entity.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';
import 'package:husbandman/src/auth/domain/use-cases/validate_user.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'auth_repo.mock.dart';

void main() {
  late AuthRepo authRepo;
  late ValidateUser useCase;

  final tUserEntity = UserEntity.empty();
  const tToken = 'token';

  setUp(() {
    authRepo = MockAuthRepo();
    useCase = ValidateUser(authRepo);
  });

  group('ValidateUser', () {
    test('Should return [Right(DataMap)] when successful', () async {
      when(
        () => authRepo.validateUser(
          token: any(named: 'token'),
        ),
      ).thenAnswer(
        (_) async => Right(tUserEntity),
      );

      final result = await useCase(tToken);

      expect(result, equals(Right<dynamic, UserEntity>(tUserEntity)));

      verify(() => authRepo.validateUser(token: tToken));
      verifyNoMoreInteractions(authRepo);
    });

    test('Should return [Left(ServerFailure)] when successful', () async {
      when(() => authRepo.validateUser(token: any(named: 'token'))).thenAnswer(
        (_) async => Left(
          ServerFailure(message: 'User not found', statusCode: 404),
        ),
      );

      final result = await useCase(tToken);

      expect(
        result,
        equals(
          Left<ServerFailure, dynamic>(
            ServerFailure(message: 'User not found', statusCode: 404),
          ),
        ),
      );

      verify(() => authRepo.validateUser(token: tToken));
      verifyNoMoreInteractions(authRepo);
    });
  });
}
