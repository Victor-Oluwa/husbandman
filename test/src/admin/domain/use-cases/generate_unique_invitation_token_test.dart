import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/admin/domain/repo/admin_repo.dart';
import 'package:husbandman/src/admin/domain/use-cases/generate_unique_invitation_token.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_admin_repo.dart';

void main() {
  late AdminRepo adminRepo;
  late GenerateUniqueInvitationToken usecase;

  const tToken = 'token';

  setUp(() {
    adminRepo = MockAdminRepo();
    usecase = GenerateUniqueInvitationToken(adminRepo);
  });

  group('Generate Unique Invitation Token', () {
    test('Should call AdminRepo and return Right(String)', () async {
      when(() => adminRepo.generateUniqueInvitationToken())
          .thenAnswer((_) async => const Right(tToken));

      final result = await usecase();
      expect(result, equals(const Right<dynamic, String>(tToken),),);

      verify(() => adminRepo.generateUniqueInvitationToken()).called(1);
      verifyNoMoreInteractions(adminRepo);
    });

    test('Should call AdminRepo and', () async {
      when(() => adminRepo.generateUniqueInvitationToken()).thenAnswer(
        (_) async => Left(
          ServerFailure(message: 'Tired of generating token', statusCode: 321),
        ),
      );

      final result = await usecase();
      expect(
        result,
        equals(
          Left<ServerFailure, dynamic>(
            ServerFailure(
                message: 'Tired of generating token', statusCode: 321,),
          ),
        ),
      );

      verify(() => adminRepo.generateUniqueInvitationToken()).called(1);
      verifyNoMoreInteractions(adminRepo);
    });
  });
}
