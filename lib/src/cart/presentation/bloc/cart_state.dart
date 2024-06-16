part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

class CartLoading extends CartState {
  const CartLoading();
}

class CartSet extends CartState {
  const CartSet();
}

class UpdatedItemQuantity extends CartState {
  const UpdatedItemQuantity({required this.cartItem});

  final CartItem cartItem;

  @override
  List<Object> get props => [cartItem];
}

class DeletedCartItem extends CartState {
  const DeletedCartItem();
}

class DeletedCart extends CartState {
  const DeletedCart();
}

class CartError extends CartState {
  const CartError({required this.message});

  final String message;

  @override
  List<String> get props => [message];
}

class FetchedCart extends CartState {
  const FetchedCart({required this.cart});

  final CartEntity cart;

  @override
  List<CartEntity> get props => [cart];
}
