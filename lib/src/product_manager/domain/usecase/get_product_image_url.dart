import 'dart:io';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/product_manager/domain/repo/product_manager_repo.dart';

class GetProductImageUrl
    extends UseCaseWithParams<List<String>, GetProductImageUrlParams> {
  const GetProductImageUrl(this._productManagerRepo);

  final ProductManagerRepo _productManagerRepo;

  @override
  ResultFuture<List<String>> call(GetProductImageUrlParams params) =>
      _productManagerRepo.getProductImageUrl(
          compressedFile: params.compressedFile);
}

class GetProductImageUrlParams extends Equatable {
 const GetProductImageUrlParams({
    required this.compressedFile,
  });

  GetProductImageUrlParams.empty()
      : this(
          compressedFile: [
            Uint8List.fromList([0, 2, 5, 7, 42, 255])
          ],
        );

  final List<Uint8List> compressedFile;

  @override
  List<Object> get props => [compressedFile];
}
