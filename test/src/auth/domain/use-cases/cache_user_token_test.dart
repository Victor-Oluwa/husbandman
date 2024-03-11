import 'package:dartz/dartz.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';
import 'package:husbandman/src/auth/domain/use-cases/cache_user_token.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'auth_repo.mock.dart';

void main() {
  late AuthRepo authRepo;
  late CacheUserToken usecase;

  const tToken = 'test-token';

  setUp(() {
    authRepo = MockAuthRepo();
    usecase = CacheUserToken(authRepo);
  });

  group('Cache User Token', () {
    test('Should return [Right<void>] when successful', () async {
      when(() => authRepo.cacheUserToken(token: any(named: 'token')))
          .thenAnswer((_) async => const Right(null));

      final result = await usecase(tToken);

      expect(result, equals(const Right<dynamic, void>(null)));

      verify(() => authRepo.cacheUserToken(token: tToken)).called(1);
      verifyNoMoreInteractions(authRepo);
    });

    test('Should return [Left ServerFailure] when unsuccessful', () async {
      when(() => authRepo.cacheUserToken(token: any(named: 'token')))
          .thenAnswer(
        (_) async => Left(
          ServerFailure(
            message: 'Caching package no longer compatible',
            statusCode: 400,
          ),
        ),
      );

      final result = await usecase(tToken);

      expect(
        result,
        equals(
          Left<ServerFailure, dynamic>(
            ServerFailure(
              message: 'Caching package no longer compatible',
              statusCode: 400,
            ),
          ),
        ),
      );

      verify(() => authRepo.cacheUserToken(token: tToken)).called(1);
      verifyNoMoreInteractions(authRepo);
    });
  });
}
