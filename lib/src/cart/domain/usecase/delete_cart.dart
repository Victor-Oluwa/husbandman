import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/cart/domain/repo/cart_repo.dart';

class DeleteCart extends UseCaseWithParams<void, String>{
  DeleteCart({required CartRepo cartRepo}) : _cartRepo = cartRepo;

  final CartRepo _cartRepo;

  @override
  ResultFuture<void> call(String params) {
   return _cartRepo.deleteCart(ownerId: params);
  }

}
