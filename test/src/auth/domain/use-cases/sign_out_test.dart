import 'package:dartz/dartz.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';
import 'package:husbandman/src/auth/domain/use-cases/sign_out.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'auth_repo.mock.dart';

void main() {
  late AuthRepo authRepo;
  late SignOut usecase;

  setUp(() {
    authRepo = MockAuthRepo();
    usecase = SignOut(authRepo);
  });

  group('SignOut', () {
    test(
      'Should call [AuthRepo] and return Right<void> when successful',
      () async {
        when(() => authRepo.signOut())
            .thenAnswer((_) async => const Right(null));

        final result = await usecase();
        expect(result, equals(const Right<dynamic, void>(null)));

        verify(() => authRepo.signOut()).called(1);
        verifyNoMoreInteractions(authRepo);
      },
    );

    test(
      'Should call [AuthRepo] and return Left<ServerFailure> when not successful',
      () async {
        when(() => authRepo.signOut()).thenAnswer(
          (_) async => Left(
            ServerFailure(message: 'Failed to sign out', statusCode: 404),
          ),
        );

        final result = await usecase();
        expect(
          result,
          equals(
            Left<ServerFailure, dynamic>(
              ServerFailure(message: 'Failed to sign out', statusCode: 404),
            ),
          ),
        );

        verify(() => authRepo.signOut()).called(1);
        verifyNoMoreInteractions(authRepo);
      },
    );
  });
}
