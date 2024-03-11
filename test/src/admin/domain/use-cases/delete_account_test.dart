import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/admin/domain/repo/admin_repo.dart';
import 'package:husbandman/src/admin/domain/use-cases/delete_account.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_admin_repo.dart';

void main() {
  late AdminRepo adminRepo;
  late DeleteAccount usecase;
  const tUserId = 'user-id';

  setUp(() {
    adminRepo = MockAdminRepo();
    usecase = DeleteAccount(adminRepo);
  });

  group('Delete Account', () {
    test('Should call [AdminRepo] and return [Right(void)]', () async {
      when(() => adminRepo.deleteAccount(userId: tUserId)).thenAnswer(
        (_) async => const Right(null),
      );

      final result = await usecase(tUserId);
      expect(
        result,
        equals(
          const Right<dynamic, void>(null),
        ),
      );

      verify(() => adminRepo.deleteAccount(userId: tUserId));
      verifyNoMoreInteractions(adminRepo);
    });

    test('Should call [AdminRepo] and return [Left(ServerFailure)]', () async {
      when(() => adminRepo.deleteAccount(userId: any(named: 'userId')))
          .thenAnswer(
        (_) async => Left(
          ServerFailure(
              message: 'This account refused to be deleted', statusCode: 123),
        ),
      );

      final result = await usecase(tUserId);
      expect(
        result,
        equals(
          Left<ServerFailure, dynamic>(
            ServerFailure(
              message: 'This account refused to be deleted',
              statusCode: 123,
            ),
          ),
        ),
      );

      verify(() => adminRepo.deleteAccount(userId: tUserId));
      verifyNoMoreInteractions(adminRepo);
    });
  });
}
