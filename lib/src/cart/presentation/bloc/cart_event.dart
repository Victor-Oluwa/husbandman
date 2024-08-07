part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();
}

class SetCartEvent extends CartEvent {
  const SetCartEvent({
   required this.cartEntity,
  });

 final CartEntity cartEntity;

  @override
  List<dynamic> get props => [
    cartEntity,
      ];
}

class UpdateItemQuantityEvent extends CartEvent {
  const UpdateItemQuantityEvent({
    required this.quantity,
    required this.ownerId,
    required this.itemId,
  });

  final int quantity;
  final String ownerId;
  final String itemId;

  @override
  List<dynamic> get props => [quantity, ownerId, itemId];
}

class DeleteCartItemEvent extends CartEvent {
  const DeleteCartItemEvent({
    required this.ownerId,
    required this.itemId,
  });

  final String ownerId;
  final String itemId;

  @override
  List<String> get props => [ownerId, itemId];
}

class DeleteCartEvent extends CartEvent {
  const DeleteCartEvent({required this.ownerId});

  final String ownerId;

  @override
  List<String> get props => [ownerId];
}

class FetchCartEvent extends CartEvent {
  const FetchCartEvent({required this.ownerId});

  final String ownerId;

  @override
  List<String> get props => [ownerId];
}
