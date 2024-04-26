import 'package:equatable/equatable.dart';
import 'package:husbandman/core/common/app/entities/product_entity.dart';
import 'package:husbandman/core/common/app/models/product_model.dart';
import 'package:husbandman/core/enums/set_product_type.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/product_manager/domain/repo/product_manager_repo.dart';

class SetProduct extends UseCaseWithParams<ProductEntity, SetProductParams> {
  const SetProduct(this._productManagerRepo);

  final ProductManagerRepo _productManagerRepo;

  @override
  ResultFuture<ProductEntity> call(SetProductParams params) =>
      _productManagerRepo.setSellerProduct(
        productMap: params.productMap,
        productObject: params.productObject,
        setProductType: params.setProductType,
      );
}

class SetProductParams extends Equatable {
  const SetProductParams({
    this.productMap,
    this.productObject,
    required this.setProductType,
  });

  SetProductParams.empty()
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
