import 'package:dartz/dartz.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/admin/domain/repo/admin_repo.dart';
import 'package:husbandman/src/admin/domain/use-cases/share_invitation_token_to_whatsapp.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'mock_admin_repo.dart';

void main() {
  late AdminRepo adminRepo;
  late ShareInvitationTokenToWhatsApp usecase;

  const tToken = 'token';

  setUp(() {
    adminRepo = MockAdminRepo();
    usecase = ShareInvitationTokenToWhatsApp(adminRepo);
  });

  group('Share Invitation Token To Email', () {
    test('Should call AdminRepo and return Right<void>', () async {
      when(
        () => adminRepo.shareInvitationTokenToWhatsApp(
          token: any(named: 'token'),
        ),
      ).thenAnswer((_) async => const Right(null));

      final result = await usecase(tToken);
      expect(
        result,
        equals(
          const Right<dynamic, void>(null),
        ),
      );

      verify(
        () => adminRepo.shareInvitationTokenToWhatsApp(token: tToken),
      ).called(1);
      verifyNoMoreInteractions(adminRepo);
    });

    test('Should call AdminRepo and return Left<ServerFailure>', () async {
      when(
        () => adminRepo.shareInvitationTokenToWhatsApp(
          token: any(named: 'token'),
        ),
      ).thenAnswer(
        (_) async => Left(
          ServerFailure(message: 'Failed to send token', statusCode: 123),
        ),
      );

      final result = await usecase(tToken);
      expect(
        result,
        equals(
          Left<ServerFailure, dynamic>(
            ServerFailure(message: 'Failed to send token', statusCode: 123),
          ),
        ),
      );

      verify(
        () => adminRepo.shareInvitationTokenToWhatsApp(token: tToken),
      ).called(1);
      verifyNoMoreInteractions(adminRepo);
    });
  });
}
