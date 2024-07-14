import 'package:equatable/equatable.dart';
import 'package:husbandman/core/common/app/entities/product_entity.dart';
import 'package:husbandman/core/enums/set_product_type.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/product_manager/domain/repo/product_manager_repo.dart';

class SetSellerProduct extends UseCaseWithParams<ProductEntity, SetSellerProductParams> {
  const SetSellerProduct(this._productManagerRepo);

  final ProductManagerRepo _productManagerRepo;

  @override
  ResultFuture<ProductEntity> call(SetSellerProductParams params) =>
      _productManagerRepo.setSellerProduct(
        productMap: params.productMap,
        productObject: params.productObject,
        setProductType: params.setProductType,
      );
}

class SetSellerProductParams extends Equatable {
  const SetSellerProductParams({
    required this.setProductType, this.productMap,
    this.productObject,
  });

  SetSellerProductParams.empty()
      : this(
          productObject: [ProductEntity.empty()],
          productMap: [ProductEntity.empty().toMap()],
          setProductType: SetProductType.renew,
        );

  final List<DataMap>? productMap;
  final List<ProductEntity>? productObject;
  final SetProductType setProductType;

  @override
  List<Object?> get props => [productMap, productObject];
}
