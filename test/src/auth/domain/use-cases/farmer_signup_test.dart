import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';
import 'package:husbandman/src/auth/domain/use-cases/farmer_signup.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main() {
  late AuthRepo authRepo;
  late FarmerSignUp usecase;

  const farmerSignUpParams = FarmerSignUpParams.empty();

  setUp(() {
    authRepo = MockAuthRepo();
    usecase = FarmerSignUp(authRepo);
  });

  group('FarmerSignUp', () {
    test('Should return [Right(void)] when successful', () async {
      when(
        () => authRepo.farmerSignUp(
          name: any(named: 'name'),
          email: any(named: 'email'),
          password: any(named: 'password'),
          address: any(named: 'address'),
          type: any(named: 'type'),
          invitationKey: any(named: 'invitationKey'),
        ),
      ).thenAnswer((invocation) async => const Right(null));

      final result = await usecase(farmerSignUpParams);

      expect(result, equals(const Right<dynamic, void>(null)));

      verify(
        () => authRepo.farmerSignUp(
          name: farmerSignUpParams.name,
          email: farmerSignUpParams.name,
          password: farmerSignUpParams.password,
          address: farmerSignUpParams.address,
          type: farmerSignUpParams.type,
          invitationKey: farmerSignUpParams.invitationKey,
        ),
      );

      verifyNoMoreInteractions(authRepo);
    });

    test('Should return [Left(ServerFailure)] when unsuccessful', () async {
      when(
        () => authRepo.farmerSignUp(
          name: any(named: 'name'),
          email: any(named: 'email'),
          password: any(named: 'password'),
          address: any(named: 'address'),
          type: any(named: 'type'),
          invitationKey: any(named: 'invitationKey'),
        ),
      ).thenAnswer(
        (invocation) async => Left(
          ServerFailure(message: 'User already exists', statusCode: 419),
        ),
      );

      final result = await usecase(farmerSignUpParams);

      expect(
        result,
        equals(
          Left<ServerFailure, dynamic>(
            ServerFailure(message: 'User already exists', statusCode: 419),
          ),
        ),
      );

      verify(
        () => authRepo.farmerSignUp(
          name: farmerSignUpParams.name,
          email: farmerSignUpParams.name,
          password: farmerSignUpParams.password,
          address: farmerSignUpParams.address,
          type: farmerSignUpParams.type,
          invitationKey: farmerSignUpParams.invitationKey,
        ),
      );

      verifyNoMoreInteractions(authRepo);
    });
  });
}
