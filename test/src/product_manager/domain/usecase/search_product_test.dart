import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:husbandman/src/product_manager/domain/entity/product_entity.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/product_manager/domain/repo/product_manager_repo.dart';
import 'package:husbandman/src/product_manager/domain/usecase/search_product.dart';
import 'package:mocktail/mocktail.dart';

import 'Mocked/mock_product_manager_repo.dart';

void main() {
  late ProductManagerRepo repo;
  late SearchProduct usecase;

  final tProductEntityList = [ProductEntity.empty()];
  const params = SearchProductParams.empty();
  final serverFailure = ServerFailure(
    message: 'Failed to search products',
    statusCode: 500,
  );

  setUp(() {
    repo = MockProductManagerRepo();
    usecase = SearchProduct(repo);
  });
  group('Search Product', () {
    test(
      'Should call [ProductManager Repo] and return Right<List<ProductEntity>>',
      () async {
        when(
          () => repo.searchProduct(
            query: any(named: 'query'),
            userId: any(named: 'userId'),
            searchBy: any(named: 'searchBy'),
          ),
        ).thenAnswer(
          (_) async => Right(
            tProductEntityList,
          ),
        );

        final result = await usecase(params);
        expect(
          result,
          equals(
            Right<dynamic, List<ProductEntity>>(tProductEntityList),
          ),
        );

        verify(
          () => repo.searchProduct(
            userId: params.userId,
            searchBy: params.searchBy,
            query: params.query,
          ),
        ).called(1);
        verifyNoMoreInteractions(repo);
      },
    );

    test(
      'Should call [ProductManager Repo] and return Right<ProductEntity>',
      () async {
        when(
          () => repo.searchProduct(
            query: any(named: 'query'),
            searchBy: any(named: 'searchBy'),
            userId: any(named: 'userId'),
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
          () => repo.searchProduct(
            userId: params.userId,
            query: params.query,
            searchBy: params.searchBy,
          ),
        ).called(1);
        verifyNoMoreInteractions(repo);
      },
    );
  });
}
