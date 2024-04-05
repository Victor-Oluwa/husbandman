import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:husbandman/core/common/app/entities/invitation_token_entity.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/admin/domain/repo/admin_repo.dart';
import 'package:husbandman/src/admin/domain/use-cases/fetch_all_invitation_token.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_admin_repo.dart';

void main() {
  late AdminRepo adminRepo;
  late FetchAllInvitationToken usecase;

  const tTokens = [InvitationTokenEntity.empty()];

  setUp(() {
    adminRepo = MockAdminRepo();
    usecase = FetchAllInvitationToken(adminRepo);
  });

  group('Fetch All Invitation Token', () {
    test('Should call [AdminRepo] and return [Right(InvitationToken)]',
        () async {
      when(() => adminRepo.fetchAllInvitationToken()).thenAnswer(
        (_) async => const Right(tTokens),
      );

      final result = await usecase();
      expect(
        result,
        equals(
          const Right<dynamic, List<InvitationTokenEntity>>(tTokens),
        ),
      );

      verify(() => adminRepo.fetchAllInvitationToken());
      verifyNoMoreInteractions(adminRepo);
    });

    test('Should call [AdminRepo] and return [Left(ServerFailure)]', () async {
      when(() => adminRepo.fetchAllInvitationToken()).thenAnswer(
        (_) async => Left(
          ServerFailure(
            message: 'Failed to fetch tokens',
            statusCode: 123,
          ),
        ),
      );

      final result = await usecase();

      expect(
        result,
        equals(
          Left<ServerFailure, dynamic>(
            ServerFailure(
              message: 'Failed to fetch tokens',
              statusCode: 123,
            ),
          ),
        ),
      );

      verify(() => adminRepo.fetchAllInvitationToken());
      verifyNoMoreInteractions(adminRepo);
    });
  });
}
