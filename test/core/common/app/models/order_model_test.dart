import 'dart:convert';

import 'package:husbandman/core/common/app/entities/order_entity.dart';
import 'package:husbandman/core/common/app/models/order_model.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:test/test.dart';

import '../../../../fixtures/fixtures_reader.dart';

void main() {
  final tOrderModel = OrderModel.empty();
  final tMap =
      jsonDecode(fixtures(folder: 'order', fileName: 'order.json')) as DataMap;

  test('Should be a sub class of Order Entity', () {
    expect(tOrderModel, isA<OrderEntity>());
  });

  group('fromMap', () {
    test('Should return a valid OrderModel object', () async {
      final result = OrderModel.fromMap(tMap);

      expect(result, isA<OrderEntity>());
      expect(result, equals(tOrderModel));
    });
  });

  group('toMap', () {
    test(
      'Should return a valid map from [OrderModel]',
      () async {
        final result = tOrderModel.toMap();
        expect(result, equals(tMap));
      },
    );
  });
}
