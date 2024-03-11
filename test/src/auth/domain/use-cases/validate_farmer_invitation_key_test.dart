import 'package:dartz/dartz.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';
import 'package:husbandman/src/auth/domain/use-cases/validate_farmer_invitation_key.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'auth_repo.mock.dart';

void main() {
  late AuthRepo authRepo;
  late ValidateFarmerInvitationKey usecase;

  const tInvitationKey = 'token';
  const tTokenId = 'id';

  setUp(() {
    authRepo = MockAuthRepo();
    usecase = ValidateFarmerInvitationKey(authRepo);
  });

  group('Validate Farmer Invitation Key', () {
    test(
      'Should return Right(String) when successful',
      () async {
        when(
          () => authRepo.validateFarmerInvitationKey(
            invitationKey: any(named: 'invitationKey'),
          ),
        ).thenAnswer((_) async => const Right(tTokenId));

        final result = await usecase(tInvitationKey);

        expect(result, equals(const Right<dynamic, String>(tTokenId)));

        verify(
          () => authRepo.validateFarmerInvitationKey(
            invitationKey: tInvitationKey,
          ),
        ).called(1);
        verifyNoMoreInteractions(authRepo);
      },
    );

    test('Should return [Left(ServerException)] when unsuccessful', () async {
      when(
        () => authRepo.validateFarmerInvitationKey(
          invitationKey: any(named: 'invitationKey'),
        ),
      ).thenAnswer(
        (_) async => Left(
          ServerFailure(message: 'Invalid invitation key', statusCode: 404),
        ),
      );

      final result = await usecase(tInvitationKey);

      expect(
        result,
        equals(
          Left<ServerFailure, dynamic>(
            ServerFailure(message: 'Invalid invitation key', statusCode: 404),
          ),
        ),
      );

      verify(
        () => authRepo.validateFarmerInvitationKey(
          invitationKey: tInvitationKey,
        ),
      ).called(1);
      verifyNoMoreInteractions(authRepo);
    });
  });
}
