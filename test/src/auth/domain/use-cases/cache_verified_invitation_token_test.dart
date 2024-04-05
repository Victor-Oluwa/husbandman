import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';
import 'package:husbandman/src/auth/domain/use-cases/cache_verified_invitation_token.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main() {
  late AuthRepo authRepo;
  late CacheVerifiedInvitationToken usecase;

  const tToken = 'token';

  setUp(() {
    authRepo = MockAuthRepo();
    usecase = CacheVerifiedInvitationToken(authRepo);
  });

  group('CacheVerifiedInvitationToken', () {
    test('Should call AuthRepo and return Right<void> when successful',
        () async {
      when(() => authRepo.cacheVerifiedInvitationToken(token: tToken))
          .thenAnswer((_) async => const Right(null));

      final result = await usecase(tToken);
      expect(result, equals(const Right<dynamic, void>(null)));

      verify(() => authRepo.cacheVerifiedInvitationToken(token: tToken))
          .called(1);
      verifyNoMoreInteractions(authRepo);
    });

    test(
      'Should call AuthRepo and return Left<ServerFailure> when unsuccessful',
      () async {
        when(() => authRepo.cacheVerifiedInvitationToken(token: tToken))
            .thenAnswer(
          (_) async => Left(
            ServerFailure(message: 'Failed to cache token', statusCode: 500),
          ),
        );

        final result = await usecase(tToken);

        expect(
          result,
          equals(
            Left<ServerFailure, dynamic>(
              ServerFailure(message: 'Failed to cache token', statusCode: 500),
            ),
          ),
        );

        verify(() => authRepo.cacheVerifiedInvitationToken(token: tToken))
            .called(1);
        verifyNoMoreInteractions(authRepo);
      },
    );
  });
}
