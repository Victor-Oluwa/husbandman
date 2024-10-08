import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:husbandman/src/product_manager/domain/entity/product_entity.dart';
import 'package:husbandman/src/product_manager/data/model/product_model.dart';
import 'package:husbandman/core/utils/typedef.dart';

import '../../../../fixtures/fixtures_reader.dart';

void main() {
  final tProductModel = ProductModel.empty();
  final tMap = jsonDecode(fixtures(folder: 'product', fileName: 'product.json'))
      as DataMap;

  test('Should be a sub class of ProductEntity', () {
    expect(tProductModel, isA<ProductEntity>());
  });

  group('fromMap', () {
    test(
      'Should return a valid [ProductModel] object',
      () {
        final result = ProductModel.fromMap(tMap);

        expect(result, isA<ProductModel>());
        expect(result, isA<ProductEntity>());
        expect(result, equals(tProductModel));
      },
    );
  });
}
