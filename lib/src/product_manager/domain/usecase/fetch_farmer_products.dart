import 'package:husbandman/core/common/app/entities/product_entity.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/product_manager/domain/repo/product_manager_repo.dart';

class FetchFarmerProduct
    extends UseCaseWithParams<List<ProductEntity>, String> {
  const FetchFarmerProduct(this._productManagerRepo);

  final ProductManagerRepo _productManagerRepo;

  @override
  ResultFuture<List<ProductEntity>> call(String params) =>
      _productManagerRepo.fetchFarmerProducts(params);
}
