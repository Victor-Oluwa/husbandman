import 'package:equatable/equatable.dart';
import 'package:husbandman/core/common/app/models/cart/cart_item.dart';
import 'package:husbandman/core/common/app/models/cart/cart_model.dart';
import 'package:husbandman/core/enums/set_cart_type.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/cart/domain/repo/cart_repo.dart';

class SetCart extends UseCaseWithParams<void, SetCartParams> {
  SetCart({required CartRepo cartRepo}) : _cartRepo = cartRepo;

  final CartRepo _cartRepo;

  @override
  ResultFuture<void> call(SetCartParams params) {
    return _cartRepo.setCart(
      setCartType: params.setCartType,
      pNewCartModel: params.pNewCartModel,
      pNewCartItem: params.pNewCartItem,
      mNewCartItem: params.mNewCartItem,
    );
  }
}

class SetCartParams extends Equatable {
  const SetCartParams({
    required this.setCartType,
    required this.pNewCartItem,
    required this.mNewCartItem,
    required this.pNewCartModel,
  });

  SetCartParams.empty()
      : this(
          mNewCartItem: {},
          pNewCartItem: CartItem.empty(),
          pNewCartModel: CartModel.empty(),
          setCartType: SetCartType.updateCart,
        );

  final SetCartType setCartType;
  final CartItem? pNewCartItem;
  final DataMap? mNewCartItem;
  final CartModel? pNewCartModel;

  @override
  List<Object?> get props =>
      [setCartType, pNewCartItem, mNewCartItem, pNewCartModel];
}
