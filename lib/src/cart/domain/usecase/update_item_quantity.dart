import 'package:equatable/equatable.dart';
import 'package:husbandman/core/common/app/models/cart/cart_item.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/cart/domain/repo/cart_repo.dart';

class UpdateItemQuantity
    extends UseCaseWithParams<CartItem, UpdateItemQualityParams> {
  UpdateItemQuantity({required CartRepo cartRepo}) : _cartRepo = cartRepo;

  final CartRepo _cartRepo;

  @override
  ResultFuture<CartItem> call(UpdateItemQualityParams params) {
   return _cartRepo.updateItemQuantity(
      quantity: params.quantity,
      itemId: params.itemId,
      ownerId: params.ownerId,
    );
  }
}

class UpdateItemQualityParams extends Equatable {
  const UpdateItemQualityParams({
    required this.quantity,
    required this.itemId,
    required this.ownerId,
  });

  const UpdateItemQualityParams.empty()
      : this(
          quantity: 0,
          ownerId: '',
          itemId: '',
        );

  final int quantity;
  final String itemId;
  final String ownerId;

  @override
  List<Object?> get props => [quantity, itemId, ownerId];
}
