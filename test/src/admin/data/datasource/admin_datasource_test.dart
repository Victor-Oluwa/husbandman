import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:husbandman/core/common/app/models/invitation_token_model.dart';
import 'package:husbandman/core/common/app/models/order_model.dart';
import 'package:husbandman/core/common/app/models/user/user_model.dart';
import 'package:husbandman/core/common/app/token-generator/token_generator.dart';
import 'package:husbandman/core/enums/filter_user.dart';
import 'package:husbandman/core/enums/search_user.dart';
import 'package:husbandman/core/error/exceptions.dart';
import 'package:husbandman/core/utils/constants.dart';
import 'package:husbandman/src/admin/data/datasource/admin_datasource.dart';
import 'package:husbandman/src/admin/data/datasource/admin_datasource_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockTokenGenerator extends Mock implements TokenGenerator {}

void main() {
  late AdminDatasource adminDatasource;
  late http.Client client;
  late TokenGenerator tokenGenerator;

  setUp(() {
    client = MockHttpClient();
    tokenGenerator = MockTokenGenerator();
    adminDatasource = AdminDatasourceImpl(client, tokenGenerator);
  });

  registerFallbackValue(Uri.parse('fallback-uri'));

  group('Block Account', () {
    const tAccountId = 'account-id';
    test(
      'Should call [Client] and return statusCode of [200] or [201]',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            'Account blocked successfully',
            200,
          ),
        );

        final methodCall = adminDatasource.blockAccount;
        expect(methodCall(accountId: tAccountId), completes);

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kBlockUserEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({'accountId': tAccountId}),
          ),
        );
        verifyNoMoreInteractions(client);
      },
    );

    test(
      'Should call [Client] and throw AdminException '
      ' if statusCode is not [200] or [201]',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            'Failed to block account',
            500,
          ),
        );

        final methodCall = adminDatasource.blockAccount;
        expect(
          () async => methodCall(accountId: tAccountId),
          throwsA(
            const AdminException(
              message: 'Failed to block account',
              statusCode: 500,
            ),
          ),
        );

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kBlockUserEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({'accountId': tAccountId}),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });

  group('Change Farmer Badge', () {
    const tFarmerId = 'farmer-id';
    const tBadge = 2;
    test(
      'Should call client and complete when statusCode is [200] or [201]',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            'Badge changed successfully',
            200,
          ),
        );

        final methodCall = adminDatasource.changeFarmerBadge;
        expect(
          methodCall(
            farmerId: tFarmerId,
            badge: tBadge,
          ),
          completes,
        );

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kChangeFarmerBadgeEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'farmerId': tFarmerId,
              'badge': tBadge,
            }),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );

    test(
      'Should call client and throw AdminException '
      ' when statusCode is not [200] or [201]',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            'Failed to change badge',
            500,
          ),
        );

        final methodCall = adminDatasource.changeFarmerBadge;
        expect(
          () async => methodCall(
            farmerId: tFarmerId,
            badge: tBadge,
          ),
          throwsA(
            const AdminException(
              message: 'Failed to change badge',
              statusCode: 500,
            ),
          ),
        );

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kChangeFarmerBadgeEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'farmerId': tFarmerId,
              'badge': tBadge,
            }),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });

  group('Delete Account', () {
    const tUserId = 'user-id';
    test(
      'Should call client and complete when statusCode is [200] or [201]',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response('Account deleted', 201),
        );

        final methodCall = adminDatasource.deleteAccount;
        expect(methodCall(userId: tUserId), completes);

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kDeleteAccountEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({'userId': tUserId}),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );

    test(
      'Should call client and throw AdminException '
      ' if statusCode is not [200] or [201]',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response('Failed to delete account', 500),
        );

        final methodCall = adminDatasource.deleteAccount;
        expect(
          () => methodCall(userId: tUserId),
          throwsA(
            const AdminException(
              message: 'Failed to delete account',
              statusCode: 500,
            ),
          ),
        );

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kDeleteAccountEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({'userId': tUserId}),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });

  group('Fetch All Orders', () {
    final tOrderModelsAsMap = [const OrderModel.empty().toMap()];
    const tOrderModelsObject = [OrderModel.empty()];
    test(
      'Should return List<OrderModel> when status code is [200] or [201]',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            jsonEncode(tOrderModelsAsMap),
            200,
          ),
        );

        final result = await adminDatasource.fetchAllOrders();
        expect(result, equals(tOrderModelsObject));

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kFetchAllOrdersEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
          ),
        );
        verifyNoMoreInteractions(client);
      },
    );

    test(
      'Should throw AdminException when statusCode is not [200] or [201]',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer(
          (_) async => http.Response('Failed to fetch orders', 500),
        );

        final methodCall = adminDatasource.fetchAllOrders;
        expect(
          () async => methodCall(),
          throwsA(
            const AdminException(
              message: 'Failed to fetch orders',
              statusCode: 500,
            ),
          ),
        );

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kFetchAllOrdersEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
          ),
        );
        verifyNoMoreInteractions(client);
      },
    );
  });

  group('Fetch All Invitation Token', () {
    final tInvitationTokenMap = [const InvitationTokenModel.empty().toMap()];
    const tInvitationTokens = [InvitationTokenModel.empty()];
    test(
      'Should return [List<InvitationToken>] when status code is [200] or [201]',
      () async {
        when(() => client.get(any(), headers: any(named: 'headers')))
            .thenAnswer(
          (_) async => http.Response(jsonEncode(tInvitationTokenMap), 200),
        );

        final result = await adminDatasource.fetchAllInvitationToken();
        expect(
          result,
          equals(
            tInvitationTokens,
          ),
        );

        verify(
          () => client.get(
            Uri.parse('$kBaseUrl$kFetchAllInvitationTokenEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
          ),
        );
        verifyNoMoreInteractions(client);
      },
    );

    test(
      'Should throw AdminException when status code is not [200] or [201]',
      () async {
        when(
          () => client.get(
            any(),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer(
          (_) async => http.Response('Failed to send tokens', 500),
        );

        final methodCall = adminDatasource.fetchAllInvitationToken;
        expect(
          () async => methodCall(),
          throwsA(
            const AdminException(
              message: 'Failed to send tokens',
              statusCode: 500,
            ),
          ),
        );

        verify(
          () => client.get(
            Uri.parse('$kBaseUrl$kFetchAllInvitationTokenEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
          ),
        );
        verifyNoMoreInteractions(client);
      },
    );
  });

  group('Fetch All Users', () {
    final tUsersMap = [UserModel.empty().toMap()];
    final tUserModels = [UserModel.empty()];
    test(
      'Should return List<UserModel> when successful',
      () async {
        when(
          () => client.get(
            any(),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer(
          (_) async => http.Response(jsonEncode(tUsersMap), 200),
        );

        final result = await adminDatasource.fetchAllUsers();
        expect(result, equals(tUserModels));

        verify(
          () => client.get(
            Uri.parse('$kBaseUrl$kFetchAllUsersEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );

    test(
      'Should throw AdminException when status code is not 200 or 201',
      () async {
        when(
          () => client.get(
            any(),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer((_) async => http.Response('Failed to fetch users', 500));

        final methodCall = adminDatasource.fetchAllUsers;
        expect(
          () async => methodCall(),
          throwsA(
            const AdminException(
              message: 'Failed to fetch users',
              statusCode: 500,
            ),
          ),
        );

        verify(
          () => client.get(
            Uri.parse('$kBaseUrl$kFetchAllUsersEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });

  group('Filter User', () {
    final mapListOfUsers = [UserModel.empty().toMap()];
    final listOfUsers = [UserModel.empty()];

    registerFallbackValue(FilterUserProperty.type);

    const tProperty = FilterUserProperty.type;
    const tValue = 'Farmer';
    test(
      'Should return List<UserModel> when status code is [200] or [201]',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            jsonEncode(mapListOfUsers),
            200,
          ),
        );

        final result = await adminDatasource.filterUser(
          property: tProperty,
          value: tValue,
        );
        expect(result, equals(listOfUsers));

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kFilterUserEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'property': tProperty.name,
              'value': tValue,
            }),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );

    test(
      'Should throw AdminException when status code is not [200] or [201]',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response('Failed to filter user', 500),
        );

        final methodCall = adminDatasource.filterUser;
        expect(
          () async => methodCall(
            property: tProperty,
            value: tValue,
          ),
          throwsA(
            const AdminException(
              message: 'Failed to filter user',
              statusCode: 500,
            ),
          ),
        );

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kFilterUserEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'property': tProperty.name,
              'value': tValue,
            }),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });

  group('Generate Unique Invitation Token', () {
    const tToken = '11111111111';
    const eToken = '1111111';

    test(
      'Should return a [11 digits Strings]  when successful',
      () async {
        when(() => tokenGenerator.generateToken()).thenAnswer((_) => tToken);

        final result = await adminDatasource.generateUniqueInvitationToken();
        expect(result, equals(tToken));

        verify(() => tokenGenerator.generateToken()).called(1);
        verifyNoMoreInteractions(tokenGenerator);
      },
    );

    test(
      'Should throw AdminException when operation is unsuccessful',
      () async {
        when(() => tokenGenerator.generateToken()).thenThrow(
          const AdminException(
            message: 'Failed to generate token',
            statusCode: 500,
          ),
        );

        final result = adminDatasource.generateUniqueInvitationToken();
        expect(
          result,
          throwsA(
            const AdminException(
              message: 'Failed to generate token',
              statusCode: 500,
            ),
          ),
        );

        verify(() => tokenGenerator.generateToken()).called(1);
        verifyNoMoreInteractions(tokenGenerator);
      },
    );

    test(
      'Should throw AdminException when '
      ' returned digits is less than or more than 11',
      () async {
        when(() => tokenGenerator.generateToken()).thenAnswer((_) => eToken);

        final result = adminDatasource.generateUniqueInvitationToken();
        expect(
          result,
          throwsA(
            isA<AdminException>(),
          ),
        );

        verify(() => tokenGenerator.generateToken()).called(1);
        verifyNoMoreInteractions(tokenGenerator);
      },
    );
  });

  group('Search User', () {
    final mapListOfUsers = [UserModel.empty().toMap()];
    final listOfUsers = [UserModel.empty()];

    const tQuery = 'John';
    const tProperty = SearchUserProperty.name;
    test(
      'Should return List<UserModel> when status code is 200 or 201',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response(jsonEncode(mapListOfUsers), 200),
        );

        final result = await adminDatasource.searchUser(
          query: tQuery,
          property: tProperty,
        );
        expect(result, equals(listOfUsers));

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kSearchUserEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'query': tQuery,
              'property': tProperty.name,
            }),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );

    test(
      'Should throw AdminException when status code id neither 200 or 201',
      () async {
        when(
          () => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response('Search failed', 500),
        );

        final methodCall = adminDatasource.searchUser;
        expect(
          () async => methodCall(query: tQuery, property: tProperty),
          throwsA(
            const AdminException(
              message: 'Search failed',
              statusCode: 500,
            ),
          ),
        );

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kSearchUserEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'query': tQuery,
              'property': tProperty.name,
            }),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });

  group('Save User Token', () {
    const tToken = 'token';
    test(
      'Should call complete successfully when status code is 200 or 201',
      () async {
        when(
          () => client.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer(
          (_) async => http.Response('Token saved successfully', 200),
        );

        final methodCall = adminDatasource.saveInvitationToken;
        expect(methodCall(token: tToken), completes);

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kSaveInvitationTokenEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'token': tToken,
            }),
          ),
        );
        verifyNoMoreInteractions(client);
      },
    );

    test(
      'Should call throw [AdminException] successfully when status code is 200 or 201',
      () async {
        when(
          () => client.post(
            any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'),
          ),
        ).thenAnswer(
          (_) async => http.Response('Failed to save token', 400),
        );

        final methodCall = adminDatasource.saveInvitationToken;
        expect(
          methodCall(token: tToken),
          throwsA(
            const AdminException(
              message: 'Failed to save token',
              statusCode: 400,
            ),
          ),
        );

        verify(
          () => client.post(
            Uri.parse('$kBaseUrl$kSaveInvitationTokenEndpoint'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'token': tToken,
            }),
          ),
        );
        verifyNoMoreInteractions(client);
      },
    );
  });
}
