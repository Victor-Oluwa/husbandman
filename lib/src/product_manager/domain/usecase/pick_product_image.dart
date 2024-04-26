import 'dart:io';

import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/product_manager/domain/repo/product_manager_repo.dart';

class PickProductImage extends UseCaseWithoutParams<List<File>> {
  const PickProductImage(this._productManagerRepo);

  final ProductManagerRepo _productManagerRepo;

  @override
  ResultFuture<List<File>> call() => _productManagerRepo.pickProductImage();
}
