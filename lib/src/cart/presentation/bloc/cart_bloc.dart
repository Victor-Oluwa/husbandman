import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:husbandman/core/common/app/entities/cart_entity.dart';
import 'package:husbandman/core/common/app/models/cart/cart_item.dart';
import 'package:husbandman/core/common/app/models/cart/cart_model.dart';
import 'package:husbandman/core/enums/set_cart_type.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/cart/domain/usecase/delete_cart.dart';
import 'package:husbandman/src/cart/domain/usecase/delete_cart_item.dart';
import 'package:husbandman/src/cart/domain/usecase/fetch_cart.dart';
import 'package:husbandman/src/cart/domain/usecase/set_cart.dart';
import 'package:husbandman/src/cart/domain/usecase/update_item_quantity.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
      CartBloc(
    SetCart setCart,
    UpdateItemQuantity updateItemQuantity,
    DeleteCartItem deleteCartItem,
    DeleteCart deleteCart,
    FetchCart fetchCart,
  )   : _setCart = setCart,
        _updateItemQuality = updateItemQuantity,
        _deleteCartItem = deleteCartItem,
        _deleteCart = deleteCart,
        _fetchCart = fetchCart,
        super(CartInitial()) {
    on<CartEvent>((event, emit) {
      emit(const CartLoading());
    });
    on<SetCartEvent>(_setCartHandler);
    on<UpdateItemQuantityEvent>(_updateItemQuantityHandler);
    on<DeleteCartItemEvent>(_deleteCartItemHandler);
    on<DeleteCartEvent>(_deleteCartHandler);
    on<FetchCartEvent>(_fetchCartHandler);
  }

  final SetCart _setCart;
  final UpdateItemQuantity _updateItemQuality;
  final DeleteCartItem _deleteCartItem;
  final DeleteCart _deleteCart;
  final FetchCart _fetchCart;

  Future<void> _setCartHandler(
    SetCartEvent event,
    Emitter<CartState> emit,
  ) async {
    final result = await _setCart(
      SetCartParams(
        setCartType: event.setCartType,
        pNewCartItem: event.pNewCartItem,
        mNewCartItem: event.mNewCartItem,
        pNewCartModel: event.pNewCartModel,
      ),
    );

    result.fold(
      (l) => emit(CartError(message: l.errorMessage)),
      (_) => emit(const CartSet()),
    );
  }

  Future<void> _updateItemQuantityHandler(
    UpdateItemQuantityEvent event,
    Emitter<CartState> emit,
  ) async {
    final result = await _updateItemQuality(
      UpdateItemQualityParams(
        quantity: event.quantity,
        itemId: event.itemId,
        ownerId: event.ownerId,
      ),
    );

    result.fold(
      (l) => emit(CartError(message: l.errorMessage)),
      (r) => emit(
        UpdatedItemQuantity(cartItem: r),
      ),
    );
  }

  Future<void> _deleteCartItemHandler(
    DeleteCartItemEvent event,
    Emitter<CartState> emit,
  ) async {
    final result = await _deleteCartItem(
      DeleteCartItemParams(
        ownerId: event.ownerId,
        itemId: event.itemId,
      ),
    );

    result.fold(
      (l) => CartError(message: l.errorMessage),
      (_) => emit(const DeletedCartItem()),
    );
  }

  Future<void> _deleteCartHandler(
    DeleteCartEvent event,
    Emitter<CartState> emit,
  ) async {
    final result = await _deleteCart(event.ownerId);

    result.fold(
      (l) => CartError(message: l.errorMessage),
      (_) => emit(const DeletedCart()),
    );
  }

  Future<void> _fetchCartHandler(
    FetchCartEvent event,
    Emitter<CartState> emit,
  ) async {
    final result = await _fetchCart(event.ownerId);

    result.fold(
      (l) => emit(CartError(message: l.errorMessage)),
      (r) => emit(
        FetchedCart(cart: r),
      ),
    );
  }
}
