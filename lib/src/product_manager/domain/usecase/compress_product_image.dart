import 'dart:io';
import 'dart:typed_data';

import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/product_manager/domain/repo/product_manager_repo.dart';

class CompressProductImage
    extends UseCaseWithParams<List<Uint8List?>, List<File>> {
  const CompressProductImage(this._repo);

  final ProductManagerRepo _repo;

  @override
  ResultFuture<List<Uint8List?>> call(List<File> params) =>
      _repo.compressProductImage(params);
}
