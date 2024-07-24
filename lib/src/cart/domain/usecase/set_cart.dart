import 'package:husbandman/src/cart/domain/entity/cart_entity.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/cart/domain/repo/cart_repo.dart';

class SetCart extends UseCaseWithParams<void, CartEntity> {
  SetCart({required CartRepo cartRepo}) : _cartRepo = cartRepo;

  final CartRepo _cartRepo;

  @override
  ResultFuture<void> call(CartEntity params) {
    return _cartRepo.setCart(
      cartEntity: params,
    );
  }
}
