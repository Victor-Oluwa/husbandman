import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/cart/domain/entity/cart_entity.dart';
import 'package:husbandman/src/product_manager/domain/repo/product_manager_repo.dart';

class AddProductToCart
    extends UseCaseWithParams<CartEntity, AddProductToCartParams> {
  AddProductToCart({required ProductManagerRepo repo}) : _repo = repo;

  final ProductManagerRepo _repo;

  @override
  ResultFuture<CartEntity> call(AddProductToCartParams params) {
    return _repo.addProductToCart(
      productId: params.productId,
      quantity: params.quantity,
      cartOwnerId: params.cartOwnerId,
    );
  }
}

class AddProductToCartParams {
  AddProductToCartParams({
    required this.productId,
    required this.quantity,
    required this.cartOwnerId,
  });

  AddProductToCartParams.empty()
      : this(
    productId: 'empty.Id',
    quantity: 1,
    cartOwnerId: 'empty.id',
  );

  final String productId;
  final int quantity;
  final String cartOwnerId;
}
