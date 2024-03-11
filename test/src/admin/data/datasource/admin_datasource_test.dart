import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:husbandman/core/common/app/models/order_model.dart';
import 'package:husbandman/core/error/exceptions.dart';
import 'package:husbandman/core/utils/constants.dart';
import 'package:husbandman/src/admin/data/datasource/admin_datasource.dart';
import 'package:husbandman/src/admin/data/datasource/admin_datasource_impl.dart';
import 'package:husbandman/src/auth/data/datasource/auth_datasource.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late AdminDatasource adminDatasource;
  late http.Client client;

  registerFallbackValue(Uri.parse('fallback-uri'));

  setUp(() {
    client = MockHttpClient();
    adminDatasource = AdminDatasourceImpl(client);
  });

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
    final tOrderModelsAsMap = [OrderModel.empty().toMap()];
    final tOrderModelsObject = [OrderModel.empty()];
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
}
