import 'package:equatable/equatable.dart';
import 'package:husbandman/src/product_manager/domain/entity/product_entity.dart';
import 'package:husbandman/core/enums/update_product.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/product_manager/domain/repo/product_manager_repo.dart';

class UpdateProduct
    extends UseCaseWithParams<ProductEntity, UpdateProductParams> {
  const UpdateProduct(this._productManagerRepo);

  final ProductManagerRepo _productManagerRepo;

  @override
  ResultFuture<ProductEntity> call(UpdateProductParams params) =>
      _productManagerRepo.updateProduct(
        newData: params.newData,
        culprit: params.culprit,
      );
}

class UpdateProductParams extends Equatable {
  const UpdateProductParams({
    required this.newData,
    required this.culprit,
  });

  const UpdateProductParams.empty()
      : this(newData: 500, culprit: UpdateProductCulprit.price);

  final dynamic newData;
  final UpdateProductCulprit culprit;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
