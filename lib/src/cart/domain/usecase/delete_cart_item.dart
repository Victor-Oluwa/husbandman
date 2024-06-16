import 'package:equatable/equatable.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/cart/domain/repo/cart_repo.dart';

class DeleteCartItem extends UseCaseWithParams<void, DeleteCartItemParams> {
  DeleteCartItem({required CartRepo cartRepo}) : _cartRepo = cartRepo;

  final CartRepo _cartRepo;

  @override
  ResultFuture<void> call(DeleteCartItemParams params) {
    return _cartRepo.deleteCartItem(
      ownerId: params.ownerId,
      itemId: params.itemId,
    );
  }
}

class DeleteCartItemParams extends Equatable {
  const DeleteCartItemParams({
    required this.ownerId,
    required this.itemId,
  });

  const DeleteCartItemParams.empty()
      : this(
          ownerId: '',
          itemId: '',
        );

  final String ownerId;
  final String itemId;

  @override
  List<Object?> get props => [ownerId, itemId];
}
