import 'package:dartz/dartz.dart';
import 'package:husbandman/core/common/app/models/user/buyer_model.dart';
import 'package:husbandman/core/common/app/models/user/farmer_model.dart';
import 'package:husbandman/core/common/app/models/user/user_model.dart';
import 'package:husbandman/core/enums/update_user.dart';
import 'package:husbandman/core/error/exceptions.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/auth/data/datasource/auth_datasource.dart';
import 'package:husbandman/src/auth/data/repo/auth_repo_impl.dart';
import 'package:husbandman/src/auth/domain/entity/user_entity.dart';
import 'package:husbandman/src/auth/domain/use-cases/farmer_signup.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockAuthDataSource extends Mock implements AuthDataSource {}

void main() {
  late AuthDataSource authDataSource;
  late AuthRepoImpl authRepoImpl;

  final tBuyerUser = BuyerModel.empty();
  final tFarmerUser = FarmerModel.empty();

  final tDataMap = {
    'name': 'James',
    'email': 'jame@gmail.com',
    'age': 24,
  };
  const tResetPasswordToken = 'password-token';

  const tEmail = 'dd.kanui@gmail.com';
  const tPassword = 'dd.kanui@password';
  const tUserToken = 'tUserToken';
  const tInvitationKey = 'invitation-key';
  const tKeyId = 'invitation-key';

  const tNewPassword = 'new-password';

  registerFallbackValue(UpdateUserCulprit.name);
  registerFallbackValue(UserEntity.empty());

  const farmerSignUpParams = FarmerSignUpParams.empty();

  setUp(() {
    authDataSource = MockAuthDataSource();
    authRepoImpl = AuthRepoImpl(authDataSource);
  });

  group('Authenticate Reset Password Token', () {
    test('Should return [Right(true)] when successful', () async {
      when(
        () => authDataSource.authenticateResetPasswordToken(
          token: any(named: 'token'),
        ),
      ).thenAnswer((_) async => true);

      final result = await authRepoImpl.authenticateResetPasswordToken(
        token: tResetPasswordToken,
      );

      expect(result, equals(const Right<dynamic, bool>(true)));

      verify(
        () => authDataSource.authenticateResetPasswordToken(
          token: tResetPasswordToken,
        ),
      ).called(1);
      verifyNoMoreInteractions(authDataSource);
    });

    test(
      'Should return Left [Left(AuthFailure)] when unsuccessful',
      () async {
        when(
          () => authDataSource.authenticateResetPasswordToken(
            token: tResetPasswordToken,
          ),
        ).thenThrow(
          const AuthException(
            message: 'Invalid Token',
            statusCode: 400,
          ),
        );

        final result = await authRepoImpl.authenticateResetPasswordToken(
          token: tResetPasswordToken,
        );

        expect(
          result,
          equals(
            Left<AuthFailure, dynamic>(
              AuthFailure(
                message: 'Invalid Token',
                statusCode: 400,
              ),
            ),
          ),
        );

        verify(
          () => authDataSource.authenticateResetPasswordToken(
            token: tResetPasswordToken,
          ),
        ).called(1);
        verifyNoMoreInteractions(authDataSource);
      },
    );
  });

  group('Buyer Sign Up', () {
    test('Should return [Right(null)] when successful', () async {
      when(
        () => authDataSource.signUp(
          name: any(named: 'name'),
          email: any(named: 'email'),
          password: any(named: 'password'),
          address: any(named: 'address'),
          type: any(named: 'type'),
        ),
      ).thenAnswer((_) async => tBuyerUser);

      final result = await authRepoImpl.signUp(
        name: farmerSignUpParams.name,
        email: farmerSignUpParams.email,
        password: farmerSignUpParams.password,
        address: farmerSignUpParams.address,
        type: farmerSignUpParams.type,
      );

      expect(result, equals(Right<dynamic, BuyerModel>(tBuyerUser)));

      verify(
        () => authDataSource.signUp(
          name: farmerSignUpParams.name,
          email: farmerSignUpParams.email,
          password: farmerSignUpParams.password,
          address: farmerSignUpParams.address,
          type: farmerSignUpParams.type,
        ),
      ).called(1);

      verifyNoMoreInteractions(authDataSource);
    });

    test('Should return [Left(AuthFailure)] when successful', () async {
      when(
        () => authDataSource.signUp(
          name: any(named: 'name'),
          email: any(named: 'email'),
          password: any(named: 'password'),
          address: any(named: 'address'),
          type: any(named: 'type'),
        ),
      ).thenThrow(
        const AuthException(
          message: 'Invalid activation key',
          statusCode: 401,
        ),
      );

      final result = await authRepoImpl.signUp(
        name: farmerSignUpParams.name,
        email: farmerSignUpParams.email,
        password: farmerSignUpParams.password,
        address: farmerSignUpParams.address,
        type: farmerSignUpParams.type,
      );

      expect(
        result,
        equals(
          Left<AuthFailure, dynamic>(
            AuthFailure(
              message: 'Invalid activation key',
              statusCode: 401,
            ),
          ),
        ),
      );

      verify(
        () => authDataSource.signUp(
          name: farmerSignUpParams.name,
          email: farmerSignUpParams.email,
          password: farmerSignUpParams.password,
          address: farmerSignUpParams.address,
          type: farmerSignUpParams.type,
        ),
      ).called(1);

      verifyNoMoreInteractions(authDataSource);
    });
  });

  group('Cache User Token', () {
    test('Should return [Right(void)] when successful', () async {
      when(() => authDataSource.cacheUserToken(token: any(named: 'token')))
          .thenAnswer((_) async => Future.value());

      final result = await authRepoImpl.cacheUserToken(token: tUserToken);

      expect(result, equals(const Right<dynamic, void>(null)));

      verify(() => authDataSource.cacheUserToken(token: tUserToken)).called(1);
      verifyNoMoreInteractions(authDataSource);
    });

    test('Should return [Left(AuthFailure)] when unsuccessful', () async {
      when(() => authDataSource.cacheUserToken(token: any(named: 'token')))
          .thenThrow(
        const AuthException(
          message: 'Your caching package fucked up',
          statusCode: 411,
        ),
      );

      final result = await authRepoImpl.cacheUserToken(token: tUserToken);

      expect(
        result,
        equals(
          Left<AuthFailure, dynamic>(
            AuthFailure(
              message: 'Your caching package fucked up',
              statusCode: 411,
            ),
          ),
        ),
      );

      verify(() => authDataSource.cacheUserToken(token: tUserToken)).called(1);
      verifyNoMoreInteractions(authDataSource);
    });
  });

  group(
    'CacheVerifiedInvitationToken',
    () {
      const tToken = 'token';
      test(
        'Should call AuthDatasource and return Right<void> when successful',
        () async {
          when(
            () => authDataSource.cacheVerifiedInvitationToken(
              token: any(named: 'token'),
            ),
          ).thenAnswer(
            (_) async => Future.value(),
          );

          final result =
              await authRepoImpl.cacheVerifiedInvitationToken(token: tToken);
          expect(result, equals(const Right<void, void>(null)));

          verify(
            () => authDataSource.cacheVerifiedInvitationToken(token: tToken),
          ).called(1);
          verifyNoMoreInteractions(authDataSource);
        },
      );

      test('Should call AuthDatasource and return Left<AuthFailure>', () async {
        when(() => authDataSource.cacheVerifiedInvitationToken(token: tToken))
            .thenThrow(
          const AuthException(
            message: 'Failed to cache token',
            statusCode: 500,
          ),
        );

        final result =
            await authRepoImpl.cacheVerifiedInvitationToken(token: tToken);
        expect(
          result,
          equals(
            Left<AuthFailure, dynamic>(
              AuthFailure(
                message: 'Failed to cache token',
                statusCode: 500,
              ),
            ),
          ),
        );

        verify(() => authDataSource.cacheVerifiedInvitationToken(token: tToken))
            .called(1);
        verifyNoMoreInteractions(authDataSource);
      });
    },
  );

  group('Farmer Sign Up', () {
    test('Should return [Right(null)] when successful', () async {
      when(
        () => authDataSource.farmerSignUp(
          name: any(named: 'name'),
          email: any(named: 'email'),
          password: any(named: 'password'),
          address: any(named: 'address'),
          type: any(named: 'type'),
          invitationKey: any(named: 'invitationKey'),
        ),
      ).thenAnswer((_) async => tFarmerUser);

      final result = await authRepoImpl.farmerSignUp(
        name: farmerSignUpParams.name,
        email: farmerSignUpParams.email,
        password: farmerSignUpParams.password,
        address: farmerSignUpParams.address,
        type: farmerSignUpParams.type,
        invitationKey: farmerSignUpParams.invitationKey,
      );

      expect(result, equals( Right<dynamic, UserEntity>(tFarmerUser)));

      verify(
        () => authDataSource.farmerSignUp(
          name: farmerSignUpParams.name,
          email: farmerSignUpParams.email,
          password: farmerSignUpParams.password,
          address: farmerSignUpParams.address,
          type: farmerSignUpParams.type,
          invitationKey: farmerSignUpParams.invitationKey,
        ),
      ).called(1);

      verifyNoMoreInteractions(authDataSource);
    });

    test('Should return [Left(AuthFailure)] when successful', () async {
      when(
        () => authDataSource.farmerSignUp(
          name: any(named: 'name'),
          email: any(named: 'email'),
          password: any(named: 'password'),
          address: any(named: 'address'),
          type: any(named: 'type'),
          invitationKey: any(named: 'invitationKey'),
        ),
      ).thenThrow(
        const AuthException(
          message: 'Invalid activation key',
          statusCode: 401,
        ),
      );

      final result = await authRepoImpl.farmerSignUp(
        name: farmerSignUpParams.name,
        email: farmerSignUpParams.email,
        password: farmerSignUpParams.password,
        address: farmerSignUpParams.address,
        type: farmerSignUpParams.type,
        invitationKey: farmerSignUpParams.invitationKey,
      );

      expect(
        result,
        equals(
          Left<AuthFailure, dynamic>(
            AuthFailure(
              message: 'Invalid activation key',
              statusCode: 401,
            ),
          ),
        ),
      );

      verify(
        () => authDataSource.farmerSignUp(
          name: farmerSignUpParams.name,
          email: farmerSignUpParams.email,
          password: farmerSignUpParams.password,
          address: farmerSignUpParams.address,
          type: farmerSignUpParams.type,
          invitationKey: farmerSignUpParams.invitationKey,
        ),
      ).called(1);

      verifyNoMoreInteractions(authDataSource);
    });
  });

  group('Reset Password', () {
    test('Should return [Right(void)] when successful', () async {
      when(() => authDataSource.resetPassword(newPassword: tNewPassword))
          .thenAnswer(
        (_) async => Future.value(),
      );

      final result =
          await authRepoImpl.resetPassword(newPassword: tNewPassword);

      expect(
        result,
        equals(
          const Right<dynamic, void>(null),
        ),
      );

      verify(() => authDataSource.resetPassword(newPassword: tNewPassword));
      verifyNoMoreInteractions(authDataSource);
    });

    test('Should return [Left(AuthFailure)] when unsuccessful', () async {
      when(() => authDataSource.resetPassword(newPassword: tNewPassword))
          .thenThrow(
        const AuthException(
          message: 'Password changed too many times. Try again in 2 years sir',
          statusCode: 419,
        ),
      );

      final result =
          await authRepoImpl.resetPassword(newPassword: tNewPassword);

      expect(
        result,
        equals(
          Left<AuthFailure, dynamic>(
            AuthFailure(
              message:
                  'Password changed too many times. Try again in 2 years sir',
              statusCode: 419,
            ),
          ),
        ),
      );

      verify(() => authDataSource.resetPassword(newPassword: tNewPassword));
      verifyNoMoreInteractions(authDataSource);
    });
  });

  group('Send Reset Password Token', () {
    test('Should return [Right(null)] when successful', () async {
      when(
        () => authDataSource.sendResetPasswordToken(
          email: any(named: 'email'),
        ),
      ).thenAnswer((_) async => Future.value());

      final result = await authRepoImpl.sendResetPasswordToken(
        email: tEmail,
      );

      expect(result, equals(const Right<dynamic, void>(null)));

      verify(() => authDataSource.sendResetPasswordToken(email: tEmail))
          .called(1);

      verifyNoMoreInteractions(authDataSource);
    });

    test('Should return [Left(AuthFailure)] when successful', () async {
      when(
        () => authDataSource.sendResetPasswordToken(
          email: any(named: 'email'),
        ),
      ).thenThrow(
        const AuthException(
          message: 'Invalid email',
          statusCode: 401,
        ),
      );

      final result = await authRepoImpl.sendResetPasswordToken(
        email: tEmail,
      );

      expect(
        result,
        equals(
          Left<AuthFailure, dynamic>(
            AuthFailure(message: 'Invalid email', statusCode: 401),
          ),
        ),
      );

      verify(() => authDataSource.sendResetPasswordToken(email: tEmail))
          .called(1);

      verifyNoMoreInteractions(authDataSource);
    });
  });

  group('Retrieve User Token', () {
    test('Should return [Right(null)] when successful', () async {
      when(
        () => authDataSource.retrieveUserToken(),
      ).thenAnswer((_) async => tUserToken);

      final result = await authRepoImpl.retrieveUserToken();

      expect(result, equals(const Right<dynamic, String>(tUserToken)));

      verify(() => authDataSource.retrieveUserToken()).called(1);

      verifyNoMoreInteractions(authDataSource);
    });

    test('Should return [Left(AuthFailure)] when successful', () async {
      when(
        () => authDataSource.retrieveUserToken(),
      ).thenThrow(
        const AuthException(
          message: 'Token not found',
          statusCode: 401,
        ),
      );

      final result = await authRepoImpl.retrieveUserToken();

      expect(
        result,
        equals(
          Left<AuthFailure, dynamic>(
            AuthFailure(message: 'Token not found', statusCode: 401),
          ),
        ),
      );

      verify(() => authDataSource.retrieveUserToken()).called(1);

      verifyNoMoreInteractions(authDataSource);
    });
  });

  group('Set User', () {
    test('Should return [Right(null)] when successful', () async {
      when(
        () => authDataSource.setUser(user: any(named: 'user')),
      ).thenAnswer((_) async => tBuyerUser);

      final result = await authRepoImpl.setUser(user: tDataMap);

      expect(result, equals(Right<dynamic, UserModel>(tBuyerUser)));

      verify(() => authDataSource.setUser(user: tDataMap)).called(1);

      verifyNoMoreInteractions(authDataSource);
    });

    test('Should return [Left(AuthFailure)] when successful', () async {
      when(
        () => authDataSource.setUser(user: any(named: 'user')),
      ).thenThrow(
        const AuthException(
          message: 'Token is empty',
          statusCode: 401,
        ),
      );

      final result = await authRepoImpl.setUser(user: tDataMap);

      expect(
        result,
        equals(
          Left<AuthFailure, dynamic>(
            AuthFailure(message: 'Token is empty', statusCode: 401),
          ),
        ),
      );

      verify(() => authDataSource.setUser(user: tDataMap)).called(1);

      verifyNoMoreInteractions(authDataSource);
    });
  });

  group('Sign In', () {
    test('Should return [UserModel] when operation is successful', () async {
      when(
        () => authDataSource.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => tBuyerUser);

      final result = await authRepoImpl.signIn(
        email: tEmail,
        password: tPassword,
      );

      expect(result, equals(Right<dynamic, BuyerModel>(tBuyerUser)));

      verify(() => authDataSource.signIn(email: tEmail, password: tPassword));
      verifyNoMoreInteractions(authDataSource);
    });

    test('Should return [Right(AuthFailure())] when unsuccessful', () async {
      when(
        () => authDataSource.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(
        const AuthException(
          message: 'Invalid Email',
          statusCode: 401,
        ),
      );

      final result = await authRepoImpl.signIn(
        email: tEmail,
        password: tPassword,
      );

      expect(
        result,
        equals(
          Left<AuthFailure, dynamic>(
            AuthFailure(
              message: 'Invalid Email',
              statusCode: 401,
            ),
          ),
        ),
      );

      verify(() => authDataSource.signIn(email: tEmail, password: tPassword));
      verifyNoMoreInteractions(authDataSource);
    });
  });

  group('Sign out', () {
    test(
      'Should call [AuthDatasource] and return Right<void>',
      () async {
        when(() => authDataSource.signOut()).thenAnswer(
          (_) async => Future.value(),
        );

        final result = await authRepoImpl.signOut();
        expect(result, equals(const Right<dynamic, void>(null)));

        verify(() => authDataSource.signOut()).called(1);
        verifyNoMoreInteractions(authDataSource);
      },
    );

    test(
      'Should call [AuthDatasource] and return Right<void>',
      () async {
        when(() => authDataSource.signOut()).thenThrow(
          const AuthException(
            message: 'Failed to sign out',
            statusCode: 404,
          ),
        );

        final result = await authRepoImpl.signOut();
        expect(
          result,
          equals(
            Left<AuthFailure, dynamic>(
              AuthFailure(
                message: 'Failed to sign out',
                statusCode: 404,
              ),
            ),
          ),
        );

        verify(() => authDataSource.signOut()).called(1);
        verifyNoMoreInteractions(authDataSource);
      },
    );
  });

  group('Update User', () {
    test('Should return [Right(null)] when successful', () async {
      when(
        () => authDataSource.updateUser(
          newData: 'Johnson',
          culprit: any(named: 'culprit'),
        ),
      ).thenAnswer((_) async => tBuyerUser);

      final result = await authRepoImpl.updateUser(
        newData: 'Johnson',
        culprit: UpdateUserCulprit.name,
      );

      expect(result, equals(Right<dynamic, BuyerModel>(tBuyerUser)));

      verify(
        () => authDataSource.updateUser(
          newData: 'Johnson',
          culprit: UpdateUserCulprit.name,
        ),
      ).called(1);

      verifyNoMoreInteractions(authDataSource);
    });

    test('Should return [Left(AuthFailure)] when successful', () async {
      when(
        () => authDataSource.updateUser(
          newData: 'Johnson',
          culprit: any(named: 'culprit'),
        ),
      ).thenThrow(
        const AuthException(
          message: 'User not found',
          statusCode: 401,
        ),
      );

      final result = await authRepoImpl.updateUser(
        newData: 'Johnson',
        culprit: UpdateUserCulprit.name,
      );

      expect(
        result,
        equals(
          Left<AuthFailure, dynamic>(
            AuthFailure(message: 'User not found', statusCode: 401),
          ),
        ),
      );

      verify(
        () => authDataSource.updateUser(
          newData: 'Johnson',
          culprit: UpdateUserCulprit.name,
        ),
      );

      verifyNoMoreInteractions(authDataSource);
    });
  });

  group('Validate User', () {
    test('Should return [Right(DataMap)] when operation is successful',
        () async {
      when(() => authDataSource.validateUser(token: any(named: 'token')))
          .thenAnswer((_) async => tBuyerUser);

      final result = await authRepoImpl.validateUser(token: tUserToken);

      expect(result, equals(Right<dynamic, UserEntity>(tBuyerUser)));

      verify(() => authDataSource.validateUser(token: tUserToken));
      verifyNoMoreInteractions(authDataSource);
    });

    test('Should return [Left(AuthFailure)] when unsuccessful', () async {
      when(
        () => authDataSource.validateUser(token: any(named: 'token')),
      ).thenThrow(
        const AuthException(
          message: 'Invalid token',
          statusCode: 401,
        ),
      );

      final result = await authRepoImpl.validateUser(token: tUserToken);

      expect(
        result,
        equals(
          Left<AuthFailure, dynamic>(
            AuthFailure(
              message: 'Invalid token',
              statusCode: 401,
            ),
          ),
        ),
      );

      verify(() => authDataSource.validateUser(token: tUserToken));
      verifyNoMoreInteractions(authDataSource);
    });
  });

  group('Validate Farmer InvitationKey', () {
    test('Should return [Right(String)] when operation is successful',
        () async {
      when(
        () => authDataSource.validateFarmerInvitationKey(
          invitationKey: any(named: 'invitationKey'),
        ),
      ).thenAnswer((_) async => tInvitationKey);

      final result = await authRepoImpl.validateFarmerInvitationKey(
        invitationKey: tInvitationKey,
      );

      expect(result, equals(const Right<dynamic, String>(tKeyId)));

      verify(
        () => authDataSource.validateFarmerInvitationKey(
          invitationKey: tInvitationKey,
        ),
      );

      verifyNoMoreInteractions(authDataSource);
    });

    test('Should return [Left(AuthFailure)] when unsuccessful', () async {
      when(
        () => authDataSource.validateFarmerInvitationKey(
          invitationKey: any(named: 'invitationKey'),
        ),
      ).thenThrow(
        const AuthException(
          message: 'Invalid token',
          statusCode: 404,
        ),
      );

      final result = await authRepoImpl.validateFarmerInvitationKey(
        invitationKey: tInvitationKey,
      );

      expect(
        result,
        equals(
          Left<AuthFailure, dynamic>(
            AuthFailure(
              message: 'Invalid token',
              statusCode: 404,
            ),
          ),
        ),
      );

      verify(
        () => authDataSource.validateFarmerInvitationKey(
          invitationKey: tInvitationKey,
        ),
      );
      verifyNoMoreInteractions(authDataSource);
    });
  });
}
