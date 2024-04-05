import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/admin/domain/repo/admin_repo.dart';
import 'package:husbandman/src/admin/domain/use-cases/save_invitation_token.dart';
import 'package:mocktail/mocktail.dart';
import 'mock_admin_repo.dart';

void main() {
  late AdminRepo adminRepo;
  late SaveInvitationToken usecase;

  setUp(() {
    adminRepo = MockAdminRepo();
    usecase = SaveInvitationToken(adminRepo);
  });

  const tToken = 'iToken';

  group('SaveInvitationToken', () {
    test('Should call [AdminRepo] and return [Right<void>]', () async {
      when(() => adminRepo.saveInvitationToken(token: any(named: 'token')))
          .thenAnswer((_) async => const Right(null));

      final result = await usecase(tToken);
      expect(result, equals(const Right<dynamic, void>(null)));

      verify(() => adminRepo.saveInvitationToken(token: tToken));
      verifyNoMoreInteractions(adminRepo);
    });

    test('Should call [AuthRepo] and return [Right<ServerFailure>]', () async {
      when(
        () => adminRepo.saveInvitationToken(
          token: any(named: 'token'),
        ),
      ).thenAnswer(
        (_) async => Left(
          ServerFailure(message: 'Token already exist', statusCode: 400),
        ),
      );

      final result = await usecase(tToken);
      expect(
        result,
        equals(
          Left<ServerFailure, void>(
            ServerFailure(message: 'Token already exist', statusCode: 400),
          ),
        ),
      );

      verify(() => adminRepo.saveInvitationToken(token: tToken));
      verifyNoMoreInteractions(adminRepo);
    });
  });
}
