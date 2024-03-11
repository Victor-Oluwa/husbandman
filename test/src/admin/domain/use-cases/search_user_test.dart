import 'package:dartz/dartz.dart';
import 'package:husbandman/core/common/app/models/user/user_model.dart';
import 'package:husbandman/core/enums/search_user.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/admin/domain/repo/admin_repo.dart';
import 'package:husbandman/src/admin/domain/use-cases/search_user.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'mock_admin_repo.dart';

void main() {
  late AdminRepo adminRepo;
  late SearchUser usecase;

  final tUsers = [UserModel.empty()];

  const searchUserParams = SearchUserParams.empty();
  registerFallbackValue(SearchUserProperty.name);

  setUp(() {
    adminRepo = MockAdminRepo();
    usecase = SearchUser(adminRepo);
  });

  group('Search User', () {
    test('Should call AdminRepo and return Right(List<UserModel>)', () async {
      when(
        () => adminRepo.searchUser(
          query: any(named: 'query'),
          property: any(named: 'property'),
        ),
      ).thenAnswer((_) async => Right(tUsers));

      final result = await usecase(searchUserParams);
      expect(result, equals(Right<dynamic, List<UserModel>>(tUsers)));

      verify(
        () => adminRepo.searchUser(
          query: searchUserParams.query,
          property: searchUserParams.property,
        ),
      );
      verifyNoMoreInteractions(adminRepo);
    });

    test('Should call AdminRepo and return Left(ServerFailure)', () async {
      when(
        () => adminRepo.searchUser(
          query: any(named: 'query'),
          property: any(named: 'property'),
        ),
      ).thenAnswer(
        (_) async => Left(
          ServerFailure(message: 'User not found', statusCode: 123),
        ),
      );

      final result = await usecase(searchUserParams);
      expect(
        result,
        equals(
          Left<ServerFailure, dynamic>(
            ServerFailure(message: 'User not found', statusCode: 123),
          ),
        ),
      );

      verify(
        () => adminRepo.searchUser(
            query: searchUserParams.query, property: searchUserParams.property),
      );
      verifyNoMoreInteractions(adminRepo);
    });
  });
}
