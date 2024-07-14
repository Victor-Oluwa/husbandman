import 'package:husbandman/core/common/app/entities/cart_entity.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/cart/domain/repo/cart_repo.dart';

class FetchCart extends UseCaseWithParams<CartEntity, String> {
  FetchCart({required CartRepo cartRepo}) : _cartRepo = cartRepo;

  final CartRepo _cartRepo;

  @override
  ResultFuture<CartEntity> call(String params) {
    return _cartRepo.fetchCart(ownerId: params);
  }
}
