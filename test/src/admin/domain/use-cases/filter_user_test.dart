import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:husbandman/core/common/app/models/user/user_model.dart';
import 'package:husbandman/core/enums/filter_user.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/admin/domain/repo/admin_repo.dart';
import 'package:husbandman/src/admin/domain/use-cases/filter_user.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_admin_repo.dart';

void main() {
  late AdminRepo adminRepo;
  late FilterUser usecase;

  final tUsers = [UserModel.empty()];
  const filterUserParams = FilterUserParams.empty();

  registerFallbackValue(FilterUserProperty.type);

  setUp(() {
    adminRepo = MockAdminRepo();
    usecase = FilterUser(adminRepo);
  });

  group('Filter User', () {
    test('Should call AdminRepo and return Right(List<User>)', () async {
      when(
        () => adminRepo.filterUser(
          property: any(named: 'property'),
          value: any<String>(named: 'value'),
        ),
      ).thenAnswer((_) async => Right(tUsers));

      final result = await usecase(filterUserParams);
      expect(result, equals(Right<dynamic, List<UserModel>>(tUsers)));

      verify(
        () => adminRepo.filterUser(
          property: filterUserParams.property,
          value: filterUserParams.value,
        ),
      ).called(1);

      verifyNoMoreInteractions(adminRepo);
    });

    test('Should call AdminRepo and return Right(List<User>)', ()async {
      when(
        () => adminRepo.filterUser(
          property: any(named: 'property'),
          value: any<String>(named: 'value'),
        ),
      ).thenAnswer(
        (_) async => Left(
          ServerFailure(
            message: 'Invalid value',
            statusCode: 123,
          ),
        ),
      );

      final result = await usecase(filterUserParams);
      expect(
        result,
        equals(
          Left<ServerFailure, dynamic>(
            ServerFailure(
              message: 'Invalid value',
              statusCode: 123,
            ),
          ),
        ),
      );

      verify(
        () => adminRepo.filterUser(
          property: filterUserParams.property,
          value: filterUserParams.value,
        ),
      ).called(1);
      verifyNoMoreInteractions(adminRepo);
    });
  });
}