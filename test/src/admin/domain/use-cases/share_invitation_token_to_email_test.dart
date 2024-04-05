import 'package:dartz/dartz.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/admin/domain/repo/admin_repo.dart';
import 'package:husbandman/src/admin/domain/use-cases/share_invitation_token_to_email.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'mock_admin_repo.dart';

void main() {
  late AdminRepo adminRepo;
  late ShareInvitationTokenToEmail usecase;

  const tShareInvitationTokenToEmailParams =
      ShareInvitationTokenToEmailParams.empty();

  setUp(() {
    adminRepo = MockAdminRepo();
    usecase = ShareInvitationTokenToEmail(adminRepo);
  });

  group('Share Invitation Token To Email', () {
    test('Should call AdminRepo and return Right<void>', () async {
      when(
        () => adminRepo.shareInvitationTokenToEmail(
          token: any(named: 'token'),
          emailAddress: any(named: 'emailAddress'),
        ),
      ).thenAnswer((_) async => const Right(null));

      final result = await usecase(tShareInvitationTokenToEmailParams);
      expect(
        result,
        equals(
          const Right<dynamic, void>(null),
        ),
      );

      verify(
        () => adminRepo.shareInvitationTokenToEmail(
            token: tShareInvitationTokenToEmailParams.token,
            emailAddress: tShareInvitationTokenToEmailParams.emailAddress,),
      ).called(1);
      verifyNoMoreInteractions(adminRepo);
    });

    test('Should call AdminRepo and return Left<ServerFailure>', () async {
      when(
        () => adminRepo.shareInvitationTokenToEmail(
          token: any(named: 'token'),
          emailAddress: any(named: 'emailAddress'),
        ),
      ).thenAnswer(
        (_) async => Left(
          ServerFailure(message: 'Failed to send token', statusCode: 123),
        ),
      );

      final result = await usecase(tShareInvitationTokenToEmailParams);
      expect(
        result,
        equals(
          Left<ServerFailure, dynamic>(
            ServerFailure(message: 'Failed to send token', statusCode: 123),
          ),
        ),
      );

      verify(
        () => adminRepo.shareInvitationTokenToEmail(
            token: tShareInvitationTokenToEmailParams.token,
            emailAddress: tShareInvitationTokenToEmailParams.emailAddress,),
      ).called(1);
      verifyNoMoreInteractions(adminRepo);
    });
  });
}
