import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/product_manager/domain/repo/product_manager_repo.dart';
import 'package:husbandman/src/product_manager/domain/usecase/get_product_image_url.dart';
import 'package:mocktail/mocktail.dart';

import 'Mocked/mock_product_manager_repo.dart';

void main() {
  late ProductManagerRepo repo;
  late GetProductImageUrl usecase;

  const tProductImageUrls = ['product-urls'];
  final params = GetProductImageUrlParams.empty();
  final serverFailure = ServerFailure(
    message: 'Failed to get url',
    statusCode: 500,
  );
  const sellerName = 'sellerName';
  const isByte = true;

  setUp(() {
    repo = MockProductManagerRepo();
    usecase = GetProductImageUrl(repo);
  });
  group('Get Product Image Url', () {
    test(
      'Should call [ProductManager Repo] and return Right<List<String>>',
      () async {
        when(
          () => repo.getProductImageUrl(
              compressedFile: any(named: 'compressedFile'),
              sellerName: any(named: 'sellerName'),
              isByte: any(named: 'isByte')),
        ).thenAnswer(
          (_) async => const Right(
            tProductImageUrls,
          ),
        );

        final result = await usecase(params);
        expect(
          result,
          equals(
            const Right<dynamic, List<String>>(tProductImageUrls),
          ),
        );

        verify(
          () => repo.getProductImageUrl(
            compressedFile: params.compressedFile,
            sellerName: params.sellerName,
            isByte: isByte,
          ),
        ).called(1);
        verifyNoMoreInteractions(repo);
      },
    );

    test(
      'Should call [ProductManager Repo] and return Right<ProductEntity>',
      () async {
        when(
          () => repo.getProductImageUrl(
            compressedFile: any(named: 'compressedFile'),
            sellerName: any(named: 'sellerName'),
            isByte: any(named: 'isByte'),
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
          () => repo.getProductImageUrl(
            compressedFile: params.compressedFile,
            sellerName: params.sellerName,
            isByte: isByte,
          ),
        ).called(1);
        verifyNoMoreInteractions(repo);
      },
    );
  });
}
