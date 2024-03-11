import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/admin/domain/repo/admin_repo.dart';
import 'package:husbandman/src/admin/domain/use-cases/block_account.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_admin_repo.dart';

void main() {
  late AdminRepo adminRepo;
  late BlockAccount usecase;

  const tAccountId = 'account-id';

  setUp(() {
    adminRepo = MockAdminRepo();
    usecase = BlockAccount(adminRepo);
  });

  group('Block Account', () {
    test('Should call [AdminRepo] and return [Right<void>]', () async {
      when(() => adminRepo.blockAccount(accountId: tAccountId)).thenAnswer(
        (_) async => const Right(null),
      );

      final result = await usecase(tAccountId);
      expect(result, equals(const Right<dynamic, void>(null)));

      verify(() => adminRepo.blockAccount(accountId: tAccountId)).called(1);
      verifyNoMoreInteractions(adminRepo);
    });

    test('Should call [AdminRepo] and return [Left<ServerFailure>]', () async {
      when(() => adminRepo.blockAccount(accountId: tAccountId)).thenAnswer(
        (_) async => Left(
          ServerFailure(
            message: 'Account refused to be blocked',
            statusCode: 123,
          ),
        ),
      );

      final result = await usecase(tAccountId);
      expect(
        result,
        equals(
          Left<ServerFailure, dynamic>(
            ServerFailure(
              message: 'Account refused to be blocked',
              statusCode: 123,
            ),
          ),
        ),
      );

      verify(() => adminRepo.blockAccount(accountId: tAccountId)).called(1);
      verifyNoMoreInteractions(adminRepo);
    });
  });
}
