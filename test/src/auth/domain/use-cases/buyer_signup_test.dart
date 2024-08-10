import 'package:dartz/dartz.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/auth/domain/entity/user_entity.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';
import 'package:husbandman/src/auth/domain/use-cases/signup.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'auth_repo.mock.dart';

void main() {
  late AuthRepo authRepo;
  late SignUp usecase;

  const buyerSignUpParams = SignUpParams.empty();
  final tUserEntity = UserEntity.empty();

  setUp(() {
    authRepo = MockAuthRepo();
    usecase = SignUp(authRepo);
  });

  test('BuyerSignUp use case Should return [Right(void)] when successful',
      () async {

    when(
      () => authRepo.signUp(
        name: any(named: 'name'),
        email: any(named: 'email'),
        password: any(named: 'password'),
        type: any(named: 'type'),
        address: any(named: 'address'),
      ),
    ).thenAnswer(
      (_) async => Right(tUserEntity),
    );

    final result = await usecase(buyerSignUpParams);

    expect(result, equals( Right<dynamic, UserEntity>(tUserEntity)));

    verify(
      () => authRepo.signUp(
        name: buyerSignUpParams.name,
        email: buyerSignUpParams.email,
        password: buyerSignUpParams.password,
        type: buyerSignUpParams.type,
        address: buyerSignUpParams.address,
      ),
    ).called(1);
    verifyNoMoreInteractions(authRepo);
  });

  test('BuyerSignUp should return [Left(ServerFailure)] when unsuccessful ',
      () async {
    when(
      () => authRepo.signUp(
        name: any(named: 'name'),
        email: any(named: 'email'),
        password: any(named: 'password'),
        type: any(named: 'type'),
        address: any(named: 'address'),
      ),
    ).thenAnswer(
      (_) async =>
          Left(ServerFailure(message: 'Incorrect password', statusCode: 401)),
    );

    final result = await usecase(buyerSignUpParams);

    expect(
      result,
      Left<ServerFailure, dynamic>(
        ServerFailure(message: 'Incorrect password', statusCode: 401),
      ),
    );

    verify(
      () => authRepo.signUp(
        name: buyerSignUpParams.name,
        email: buyerSignUpParams.email,
        password: buyerSignUpParams.password,
        type: buyerSignUpParams.type,
        address: buyerSignUpParams.address,
      ),
    ).called(1);

    verifyNoMoreInteractions(authRepo);
  });
}
