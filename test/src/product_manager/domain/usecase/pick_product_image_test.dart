import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/src/product_manager/domain/repo/product_manager_repo.dart';
import 'package:husbandman/src/product_manager/domain/usecase/pick_product_image.dart';
import 'package:mocktail/mocktail.dart';

import 'Mocked/mock_product_manager_repo.dart';

void main() {
  late ProductManagerRepo repo;
  late PickProductImage usecase;

  final tImageFiles = [File('image.png')];
  final serverFailure = ServerFailure(
    message: 'Failed to pick image',
    statusCode: 500,
  );

  setUp(() {
    repo = MockProductManagerRepo();
    usecase = PickProductImage(repo);
  });
  group('Pick Product Product Image', () {
    test(
      'Should call [ProductManager Repo] and return Right<List<File>>',
          () async {
        when(() => repo.pickProductImage()).thenAnswer(
              (_) async => Right(
            tImageFiles,
          ),
        );

        final result = await usecase();
        expect(
          result,
          equals(
            Right<dynamic, List<File>>(tImageFiles),
          ),
        );

        verify(() => repo.pickProductImage()).called(1);
        verifyNoMoreInteractions(repo);
      },
    );

    test(
      'Should call [ProductManager Repo] and return Right<ProductEntity>',
          () async {
        when(() => repo.pickProductImage()).thenAnswer(
              (_) async => Left(
            serverFailure,
          ),
        );

        final result = await usecase();
        expect(
          result,
          equals(
            Left<ServerFailure, dynamic>(serverFailure),
          ),
        );

        verify(() => repo.pickProductImage()).called(1);
        verifyNoMoreInteractions(repo);
      },
    );
  });
}
