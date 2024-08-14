import 'package:husbandman/src/product_manager/domain/entity/product_entity.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/product_manager/domain/repo/product_manager_repo.dart';

class RateProduct extends UseCaseWithParams<ProductEntity, String> {
  const RateProduct(this._productManagerRepo);

  final ProductManagerRepo _productManagerRepo;

  @override
  ResultFuture<ProductEntity> call(String params) =>
      _productManagerRepo.rateProduct(params);
}
