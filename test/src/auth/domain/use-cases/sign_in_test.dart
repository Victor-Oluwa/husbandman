import 'package:dartz/dartz.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/auth/domain/entity/user_entity.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';
import 'package:husbandman/src/auth/domain/use-cases/sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'auth_repo.mock.dart';

void main() {
  late AuthRepo authRepo;
  late SignIn usecase;

  final tUserEntity = UserEntity.empty();

  const signInParams = SignInParams.empty();
  setUp(() {
    authRepo = MockAuthRepo();
    usecase = SignIn(authRepo);
  });

  group('SignUp', () {
    test('Should return Right(UserModel) when successful', () async {
      when(
        () => authRepo.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => Right(tUserEntity),
      );

      final result = await usecase(signInParams);

      expect(
        result,
        equals(
          Right<dynamic, UserEntity>(tUserEntity),
        ),
      );

      verify(
        () => authRepo.signIn(
          email: signInParams.email,
          password: signInParams.password,
        ),
      );
      verifyNoMoreInteractions(authRepo);
    });

    test('Should return Left(ServerFailure) when successful', () async {
      when(
        () => authRepo.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => Left(
          ServerFailure(message: 'Wrong password', statusCode: 419),
        ),
      );

      final result = await usecase(signInParams);

      expect(
        result,
        equals(
          Left<ServerFailure, dynamic>(
            ServerFailure(message: 'Wrong password', statusCode: 419),
          ),
        ),
      );

      verify(
        () => authRepo.signIn(
          email: signInParams.email,
          password: signInParams.password,
        ),
      );
      verifyNoMoreInteractions(authRepo);
    });
  });
}
