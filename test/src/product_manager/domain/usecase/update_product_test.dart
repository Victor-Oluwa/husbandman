import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:husbandman/core/common/app/entities/product_entity.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/product_manager/domain/repo/product_manager_repo.dart';
import 'package:husbandman/src/product_manager/domain/usecase/update_product.dart';
import 'package:mocktail/mocktail.dart';

import 'Mocked/mock_product_manager_repo.dart';

void main() {
  late ProductManagerRepo repo;
  late UpdateProduct usecase;

  final tProductEntity = ProductEntity.empty();
  const params = UpdateProductParams.empty();
  final serverFailure = ServerFailure(
    message: 'Failed to update product',
    statusCode: 500,
  );

  setUpAll(() {
    registerFallbackValue(params.culprit);
  });

  setUp(() {
    repo = MockProductManagerRepo();
    usecase = UpdateProduct(repo);
  });
  group('Update Product', () {
    test(
      'Should call [ProductManager Repo] and return Right<ProductEntity>',
      () async {
        when(
          () => repo.updateProduct(
            culprit: params.culprit,
            newData: params.newData,
          ),
        ).thenAnswer(
          (_) async => Right(
            tProductEntity,
          ),
        );

        final result = await usecase(params);
        expect(
          result,
          equals(
            Right<dynamic, ProductEntity>(tProductEntity),
          ),
        );

        verify(
          () => repo.updateProduct(
            newData: params.newData,
            culprit: params.culprit,
          ),
        ).called(1);
        verifyNoMoreInteractions(repo);
      },
    );

    test(
      'Should call [ProductManager Repo] and return Left<ServerFailure>',
      () async {
        when(
          () => repo.updateProduct(
            newData: any<String>(named: 'newData'),
            culprit: any(named: 'culprit'),
          ),
        ).thenAnswer(
          (_) async => Left(
            serverFailure,
          ),
        );

        final result = await usecase(params);
        expect(
          result,
          equals(
            Left<ServerFailure, dynamic>(serverFailure),
          ),
        );

        verify(
          () => repo.updateProduct(
              culprit: params.culprit, newData: params.newData),
        ).called(1);
        verifyNoMoreInteractions(repo);
      },
    );
  });
}
