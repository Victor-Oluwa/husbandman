import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:husbandman/core/common/app/models/user/farmer_model.dart';
import 'package:husbandman/core/common/app/provider/user_provider.dart';
import 'package:husbandman/core/common/app/storage/hbm_storage.dart';
import 'package:husbandman/core/error/exceptions.dart';
import 'package:husbandman/core/utils/constants.dart';
import 'package:husbandman/src/auth/data/datasource/auth_datasource.dart';
import 'package:husbandman/src/auth/data/datasource/auth_datasource_impl.dart';
import 'package:husbandman/core/common/app/models/user/buyer_model.dart';
import 'package:husbandman/src/auth/domain/use-cases/update_user.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockHBMStorage extends Mock implements HBMStorage {}

class MockRiverpodRef extends Mock implements Ref {}

void main() {
  late http.Client client;
  late AuthDataSource authDatasource;
  late HBMStorage storage;
  late Ref ref;

  const tPasswordToken = 'password-token';
  const tUserToken = 'user-token';
  const tNewPassword = 'new-password';
  const tEmail = 'email';
  final tFarmerMapped = FarmerModel.empty().toMap();
  final tFarmerModelResponse = BuyerModel.empty();
  final tBuyerModelResponse = BuyerModel.empty();

  registerFallbackValue(Uri());
  registerFallbackValue(const UpdateUserParams.empty());

  setUp(() {
    client = MockHttpClient();
    storage = MockHBMStorage();
    ref = MockRiverpodRef();
    authDatasource = AuthDataSourceImpl(
      client,
      storage,
      ref,
    );
  });

  group('Authenticate Reset Password Token', () {
    test('Should return [true] when status code is [200] or [201]', () async {
      when(() => client.post(any(), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response(jsonEncode(true), 200));

      final result = await authDatasource.authenticateResetPasswordToken(
        token: tPasswordToken,
      );

      expect(result, equals(true));

      verify(
        () => client.post(
          Uri.parse('$kBaseUrl$kAuthenticateResetPasswordTokenEndpoint'),
          body: jsonEncode({'token': tPasswordToken}),
        ),
      );
      verifyNoMoreInteractions(client);
    });

    test('Should return [AuthException] if status code is not [200] or [201]',
        () async {
      when(() => client.post(any(), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('Token is not correct', 400));

      final methodCall = authDatasource.authenticateResetPasswordToken;

      expect(
        () async => methodCall(token: tPasswordToken),
        throwsA(
          const AuthException(message: 'Token is not correct', statusCode: 400),
        ),
      );

      verify(
        () => client.post(
          Uri.parse('$kBaseUrl$kAuthenticateResetPasswordTokenEndpoint'),
          body: jsonEncode(
            {'token': tPasswordToken},
          ),
        ),
      ).called(1);
      verifyNoMoreInteractions(client);
    });
  });

  group('Buyer Sign Up', () {
    test('Should complete successfully when statusCode is [200] or [201]',
        () async {
      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
        (_) async => http.Response('Buyer created successfully', 200),
      );

      final methodCall = authDatasource.buyerSignUp;

      expect(
        methodCall(
          name: 'name',
          email: 'email',
          password: 'password',
          type: 'type',
          address: 'address',
        ),
        completes,
      );

      verify(
        () => client.post(
          Uri.parse('$kBaseUrl$kBuyerSignUpEndpoint'),
          body: jsonEncode({
            'name': 'name',
            'email': 'email',
            'password': 'password',
            'type': 'type',
            'address': 'address',
          }),
        ),
      ).called(1);
      verifyNoMoreInteractions(client);
    });

    test('Should throw [AuthException] when status code is not [200] or [201]',
        () async {
      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
        (_) async => http.Response('User already exist', 400),
      );

      final methodCall = authDatasource.buyerSignUp;

      expect(
        () async => methodCall(
          name: 'name',
          email: 'email',
          password: 'password',
          type: 'type',
          address: 'address',
        ),
        throwsA(
          const AuthException(message: 'User already exist', statusCode: 400),
        ),
      );

      verify(
        () => client.post(
          Uri.parse('$kBaseUrl$kBuyerSignUpEndpoint'),
          body: jsonEncode({
            'name': 'name',
            'email': 'email',
            'password': 'password',
            'type': 'type',
            'address': 'address',
          }),
        ),
      ).called(1);
      verifyNoMoreInteractions(client);
    });
  });

  group('Cache User Token', () {
    test('Should call [FlutterSecureStorage] to cache user token', () async {
      when(
        () => storage.writeData(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async => Future.value());

      await authDatasource.cacheUserToken(token: tUserToken);

      verify(
        () => storage.writeData(key: kAuthToken, value: tUserToken),
      ).called(1);
      verifyNoMoreInteractions(storage);
    });

    test(
        'Should throw [AuthException] if write to [FlutterSecureStorage fails]',
        () async {
      when(
        () => storage.writeData(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenThrow(Exception());

      final methodCall = authDatasource.cacheUserToken;

      expect(methodCall(token: tUserToken), throwsA(isA<AuthException>()));
      verify(() => storage.writeData(key: kAuthToken, value: tUserToken))
          .called(1);
      verifyNoMoreInteractions(storage);
    });
  });

  group('Farmer Sign Up', () {
    test(
      'Should complete successfully when status code is [200] or [201]',
      () async {
        when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response(
            'New farmer created successfully',
            200,
          ),
        );

        final methodCall = authDatasource.farmerSignUp;

        expect(
          methodCall(
            name: 'name',
            email: 'email',
            password: 'password',
            address: 'address',
            type: 'type',
            invitationKey: 'invitationKey',
          ),
          completes,
        );

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kFarmerSignUpEndpoint'),
            body: jsonEncode({
              'name': 'name',
              'email': 'email',
              'password': 'password',
              'address': 'address',
              'type': 'type',
              'invitationKey': 'invitationKey',
            }),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );

    test(
      'Should throw [AuthException] when status code is not 201 or [200]',
      () {
        when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response('User already exist', 400),
        );

        final methodCall = authDatasource.farmerSignUp;

        expect(
          methodCall(
            name: 'name',
            email: 'email',
            password: 'password',
            address: 'address',
            type: 'type',
            invitationKey: 'invitationKey',
          ),
          throwsA(
            const AuthException(message: 'User already exist', statusCode: 400),
          ),
        );

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kFarmerSignUpEndpoint'),
            body: jsonEncode({
              'name': 'name',
              'email': 'email',
              'password': 'password',
              'address': 'address',
              'type': 'type',
              'invitationKey': 'invitationKey',
            }),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });

  group('Retrieve User Token', () {
    test(
      'Should call FlutterSecureStorage and retrieve user token',
      () async {
        when(() => storage.readData(key: any(named: 'key')))
            .thenAnswer((_) async => tUserToken);

        final result = await authDatasource.retrieveUserToken();

        expect(result, equals(tUserToken));

        verify(() => storage.readData(key: kAuthToken));
        verifyNoMoreInteractions(storage);
      },
    );

    test(
      'Should throw [AuthException] if reading [FlutterSecureStorage] fails',
      () async {
        when(() => storage.readData(key: any(named: 'key')))
            .thenThrow(Exception());

        final methodChannel = authDatasource.retrieveUserToken;

        expect(methodChannel(), throwsA(isA<AuthException>()));

        verify(() => storage.readData(key: kAuthToken)).called(1);
        verifyNoMoreInteractions(storage);
      },
    );
  });

  group('Reset Password', () {
    test('Should complete successfully if status code is [200] or [201]',
        () async {
      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
        (_) async => http.Response('Password changed successfully', 200),
      );

      final methodCall = authDatasource.resetPassword;

      expect(methodCall(newPassword: tNewPassword), completes);

      verify(
        () => client.post(
          Uri.parse('$kBaseUrl$kResetPasswordEndpoint'),
          body: jsonEncode({'newPassword': tNewPassword}),
        ),
      ).called(1);
      verifyNoMoreInteractions(client);
    });

    test(
      'Should throw [AuthException] if status code is not [200] or [201]',
      () async {
        when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response(
            'Password changed too many times. Try again in 4 years',
            400,
          ),
        );

        final methodCall = authDatasource.resetPassword;

        expect(
          methodCall(newPassword: tNewPassword),
          throwsA(
            const AuthException(
              message: 'Password changed too many times. Try again in 4 years',
              statusCode: 400,
            ),
          ),
        );

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kResetPasswordEndpoint'),
            body: jsonEncode({'newPassword': tNewPassword}),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });

  group('Set User', () {
    test('Should call [Riverpod Ref] and set user state', () async {
      when(
        () => ref.read(farmerProvider.notifier).updateFarmerFromMap(
              map: any(named: 'map'),
            ),
      ).thenAnswer((_) => FarmerNotifier());

      await authDatasource.setUser(user: tFarmerMapped);

      verify(
        () => ref
            .read(farmerProvider.notifier)
            .updateFarmerFromMap(map: tFarmerMapped),
      ).called(1);
      verifyNoMoreInteractions(ref);
    });

    test('Should throw [AuthException] when call to [Riverpod Ref] fails',
        () async {
      when(
        () => ref
            .read(farmerProvider.notifier)
            .updateFarmerFromMap(map: any(named: 'map')),
      ).thenThrow(Exception());

      final methodCall = authDatasource.setUser;

      expect(methodCall(user: tFarmerMapped), throwsA(isA<AuthException>()));
    });
  });

  group('Send Reset Password Token', () {
    test('Should complete successfully if status code is [200] or [201]',
        () async {
      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
        (_) async => http.Response(
          'Token Sent successfully',
          200,
        ),
      );

      final methodCall = authDatasource.sendResetPasswordToken;

      expect(methodCall(email: tEmail), completes);

      verify(
        () => client.post(
          Uri.parse('$kBaseUrl$kSendResetPasswordTokenEndpoint'),
          body: jsonEncode({'email': tEmail}),
        ),
      ).called(1);
      verifyNoMoreInteractions(client);
    });

    test(
      'Should throw [AuthException] if status code is not [200] or [201]',
      () async {
        when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response(
            'Email address is not registered',
            419,
          ),
        );

        final methodCall = authDatasource.sendResetPasswordToken;

        expect(
          methodCall(email: tEmail),
          throwsA(
            const AuthException(
              message: 'Email address is not registered',
              statusCode: 419,
            ),
          ),
        );

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kSendResetPasswordTokenEndpoint'),
            body: jsonEncode({'email': tEmail}),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });

  group('Sign In', () {
    test(
      'Should return a [UserModel] when status code is [200] or [201]',
      () async {
        when(
          () => client.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            jsonEncode(tFarmerModelResponse.toMap()),
            200,
          ),
        );

        final result = await authDatasource.signIn(
          email: 'email',
          password: 'password',
        );

        expect(
          result,
          equals(tFarmerModelResponse),
        );

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kSignInEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'email': 'email',
              'password': 'password',
            }),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );

    test(
      'Should throw [AuthException] when status code is not 201 or [200]',
      () async {
        when(
          () => client.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer(
          (_) async => http.Response('Wrong password', 400),
        );

        final methodCall = authDatasource.signIn;

        expect(
          methodCall(email: 'email', password: 'password'),
          throwsA(
            const AuthException(message: 'Wrong password', statusCode: 400),
          ),
        );

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kSignInEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'email': 'email',
              'password': 'password',
            }),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });

  group('Update User', () {
    const tUpdateUserParams = UpdateUserParams.empty();
    test('Should return a [UserModel] if status code is [200] or [201]',
        () async {
      when(
        () => client.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          jsonEncode(tFarmerModelResponse.toMap()),
          200,
        ),
      );

      final result = await authDatasource.updateUser(
        newData: tUpdateUserParams.newData,
        culprit: tUpdateUserParams.culprit,
      );

      expect(result, tFarmerModelResponse);

      verify(
        () => client.post(
          Uri.parse('$kBaseUrl$kUpdateUserEndpoint'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'newData': tUpdateUserParams.newData,
            'culprit': tUpdateUserParams.culprit.name,
          }),
        ),
      ).called(1);
      verifyNoMoreInteractions(client);
    });

    test(
      'Should throw [AuthException] if status code is not [200] or [201]',
      () async {
        when(
          () => client.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            'Your name is too long sir',
            40000,
          ),
        );

        final methodCall = authDatasource.updateUser;

        expect(
          methodCall(
            culprit: tUpdateUserParams.culprit,
            newData: tUpdateUserParams.newData,
          ),
          throwsA(
            const AuthException(
              message: 'Your name is too long sir',
              statusCode: 40000,
            ),
          ),
        );

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kUpdateUserEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'newData': tUpdateUserParams.newData,
              'culprit': tUpdateUserParams.culprit.name,
            }),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });

  group('Validate User', () {
    test('Should return a [UserModel] if status code is [200] or [201]',
        () async {
      when(
        () => client.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          jsonEncode(
            tBuyerModelResponse.toMap(),
          ),
          200,
        ),
      );

      final result = await authDatasource.validateUser(token: tUserToken);

      expect(result, equals(tBuyerModelResponse));

      verify(
        () => client.post(
          Uri.parse('$kBaseUrl$kValidateUserEndpoint'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({'token': tUserToken}),
        ),
      ).called(1);
      verifyNoMoreInteractions(client);
    });

    test(
      'Should throw [AuthException] if status code is not [200] or [201]',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response('User not found', 400),
        );

        final methodCall = authDatasource.validateUser;
        expect(
          methodCall(token: tUserToken),
          throwsA(
            const AuthException(
              message: 'User not found',
              statusCode: 400,
            ),
          ),
        );

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kValidateUserEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({'token': tUserToken}),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });

  group('Validate Farmer Invitation Key', () {
    const tInvitationId = 'id';
    const tInvitationKey = 'invitation-Key';

    test('Should return a [String] if status code is [200] or [201]', () async {
      when(
        () => client.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          tInvitationId,
          200,
        ),
      );

      final result = await authDatasource.validateFarmerInvitationKey(
          invitationKey: tInvitationKey,);

      expect(result, equals(tInvitationId));

      verify(
        () => client.post(
          Uri.parse('$kBaseUrl$kValidateFarmerInvitationKeyEndpoint'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({'invitationKey': tInvitationKey}),
        ),
      ).called(1);
      verifyNoMoreInteractions(client);
    });

    test(
      'Should throw [AuthException] if status code is not [200] or [201]',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response('User not found', 400),
        );

        final methodCall = authDatasource.validateFarmerInvitationKey;
        expect(
          methodCall(invitationKey: tInvitationKey),
          throwsA(
            const AuthException(
              message: 'User not found',
              statusCode: 400,
            ),
          ),
        );

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kValidateFarmerInvitationKeyEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({'invitationKey': tInvitationKey}),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });
}
