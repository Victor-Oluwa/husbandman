import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/auth/domain/entity/user_entity.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';
import 'package:husbandman/src/auth/domain/use-cases/update_user.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main() {
  late AuthRepo authRepo;
  late UpdateUser usecase;

  const updateUserParams = UpdateUserParams.empty();
  final tUserEntity = UserEntity.empty();

  setUp(() {
    authRepo = MockAuthRepo();
    usecase = UpdateUser(authRepo);
  });

  group('UpdateUser', () {
    test('Should return [Right(void)] when successful', () async {
      when(
        () => authRepo.updateUser(
          newData: updateUserParams.newData,
          culprit: updateUserParams.culprit,
        ),
      ).thenAnswer((_) async => Right(tUserEntity));

      final result = await usecase(updateUserParams);

      expect(result, equals( Right<dynamic, UserEntity>(tUserEntity)));

      verify(
        () => authRepo.updateUser(
          newData: updateUserParams.newData,
          culprit: updateUserParams.culprit,
        ),
      );

      verifyNoMoreInteractions(authRepo);
    });

    test('Should return [Left(ServerFailure)] when unsuccessful', () async {
      when(
        () => authRepo.updateUser(
          newData: updateUserParams.newData,
          culprit: updateUserParams.culprit,
        ),
      ).thenAnswer(
        (_) async => Left(
          ServerFailure(message: 'Permission denied', statusCode: 419),
        ),
      );

      final result = await usecase(updateUserParams);

      expect(
        result,
        equals(
          Left<ServerFailure, dynamic>(
            ServerFailure(message: 'Permission denied', statusCode: 419),
          ),
        ),
      );

      verify(
        () => authRepo.updateUser(
          newData: updateUserParams.newData,
          culprit: updateUserParams.culprit,
        ),
      );

      verifyNoMoreInteractions(authRepo);
    });
  });
}
