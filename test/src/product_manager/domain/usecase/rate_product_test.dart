import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:husbandman/src/product_manager/domain/entity/product_entity.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/product_manager/domain/repo/product_manager_repo.dart';
import 'package:husbandman/src/product_manager/domain/usecase/rate_product.dart';
import 'package:mocktail/mocktail.dart';

import 'Mocked/mock_product_manager_repo.dart';

void main() {
  late ProductManagerRepo repo;
  late RateProduct usecase;

  final tProductEntity = ProductEntity.empty();
  const tId = 'product-id';
  final serverFailure = ServerFailure(
    message: 'Failed to rate product',
    statusCode: 500,
  );

  setUp(() {
    repo = MockProductManagerRepo();
    usecase = RateProduct(repo);
  });
  group('Rate Product', () {
    test(
      'Should call [ProductManager Repo] and return Right<ProductEntity>',
      () async {
        when(
          () => repo.rateProduct(any()),
        ).thenAnswer(
          (_) async => Right(
            tProductEntity,
          ),
        );

        final result = await usecase(tId);
        expect(
          result,
          equals(
            Right<dynamic, ProductEntity>(tProductEntity),
          ),
        );

        verify(() => repo.rateProduct(tId)).called(1);
        verifyNoMoreInteractions(repo);
      },
    );

    test(
      'Should call [ProductManager Repo] and return Left<ServerFailure>',
      () async {
        when(
          () => repo.rateProduct(any()),
        ).thenAnswer(
          (_) async => Left(
            serverFailure,
          ),
        );

        final result = await usecase(tId);
        expect(
          result,
          equals(
            Left<ServerFailure, dynamic>(serverFailure),
          ),
        );

        verify(() => repo.rateProduct(tId)).called(1);
        verifyNoMoreInteractions(repo);
      },
    );
  });
}
