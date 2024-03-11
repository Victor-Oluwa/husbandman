import 'package:dartz/dartz.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';
import 'package:husbandman/src/auth/domain/use-cases/retrieve_user_token.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'auth_repo.mock.dart';

void main() {
  late AuthRepo authRepo;
  late RetrieveUserToken usecase;

  const tUserToken ='user-token';

  setUp(() {
    authRepo = MockAuthRepo();
    usecase = RetrieveUserToken(authRepo);
  });

  group('Retrieve User Token', () {
    test('Should return [Right(void)] when successful', () async {
      when(() => authRepo.retrieveUserToken()).thenAnswer(
        (_) async => const Right(tUserToken),
      );

      final result = await usecase();

      expect(result, equals(const Right<dynamic, String>(tUserToken)));

      verify(() => authRepo.retrieveUserToken());
      verifyNoMoreInteractions(authRepo);
    });

    test('Should return [Left(ServerFailure)] when successful', () async {
      when(() => authRepo.retrieveUserToken()).thenAnswer(
        (_) async => Left(
          ServerFailure(message: 'Token not found', statusCode: 404),
        ),
      );

      final result = await usecase();

      expect(
        result,
        equals(
          Left<ServerFailure, dynamic>(
            ServerFailure(message: 'Token not found', statusCode: 404),
          ),
        ),
      );

      verify(() => authRepo.retrieveUserToken());
      verifyNoMoreInteractions(authRepo);
    });
  });
}
