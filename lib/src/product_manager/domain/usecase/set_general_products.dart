import 'package:equatable/equatable.dart';
import 'package:husbandman/core/common/app/entities/product_entity.dart';
import 'package:husbandman/core/common/app/models/product_model.dart';
import 'package:husbandman/core/enums/set_product_type.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/product_manager/domain/repo/product_manager_repo.dart';

class SetGeneralProducts
    extends UseCaseWithParams<void, SetGeneralProductsParams> {
  const SetGeneralProducts(this._productManagerRepo);

  final ProductManagerRepo _productManagerRepo;

  @override
  ResultFuture<void> call(SetGeneralProductsParams params) =>
      _productManagerRepo.setGeneralProducts(
        productMap: params.productMap,
        productObject: params.productObject,
        setProductType: params.setProductType,
      );
}

class SetGeneralProductsParams extends Equatable {
  const SetGeneralProductsParams({
    required this.setProductType,
    this.productMap,
    this.productObject,
  });

  SetGeneralProductsParams.empty()
      : this(
          productObject: [ProductModel.empty()],
          productMap: [ProductEntity.empty().toMap()],
          setProductType: SetProductType.renew,
        );

  final List<DataMap>? productMap;
  final List<ProductModel>? productObject;
  final SetProductType setProductType;

  @override
  List<Object?> get props => [productMap, productObject];
}
