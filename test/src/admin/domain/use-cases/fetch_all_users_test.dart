import 'package:dartz/dartz.dart';
import 'package:husbandman/core/common/app/models/user/user_model.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/admin/domain/repo/admin_repo.dart';
import 'package:husbandman/src/admin/domain/use-cases/fetch_all_users.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'mock_admin_repo.dart';

void main() {
  late AdminRepo adminRepo;
  late FetchAllUsers usecase;

  final tUserModels = [UserModel.empty()];

  setUp(() {
    adminRepo = MockAdminRepo();
    usecase = FetchAllUsers(adminRepo);
  });
  group('Fetch All Users', () {
    test('Should call AuthRepo and return Right(List<UserModel>)', () async {
      when(() => adminRepo.fetchAllUsers()).thenAnswer(
        (_) async => Right(tUserModels),
      );

      final result = await usecase();
      expect(result, equals(Right<dynamic, List<UserModel>>(tUserModels)));

      verify(() => adminRepo.fetchAllUsers()).called(1);
      verifyNoMoreInteractions(adminRepo);
    });

    test('Should call AdminRepo and return Left(ServerFailure)', () async {
      when(() => adminRepo.fetchAllUsers()).thenAnswer(
        (_) async => Left(
          ServerFailure(message: 'Failed to fetch all users', statusCode: 123),
        ),
      );

      final result = await usecase();
      expect(
        result,
        equals(
          Left<ServerFailure, dynamic>(
            ServerFailure(
              message: 'Failed to fetch all users',
              statusCode: 123,
            ),
          ),
        ),
      );

      verify(() => adminRepo.fetchAllUsers()).called(1);
      verifyNoMoreInteractions(adminRepo);
    });
  });
}
