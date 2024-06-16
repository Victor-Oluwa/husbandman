import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/src/cart/data/datasource/cart_datasource.dart';
import 'package:husbandman/src/cart/data/datasource/cart_datasource_impl.dart';
import 'package:husbandman/src/cart/data/repo/cart_repo_impl.dart';
import 'package:husbandman/src/cart/domain/repo/cart_repo.dart';
import 'package:husbandman/src/cart/domain/usecase/delete_cart.dart';
import 'package:husbandman/src/cart/domain/usecase/delete_cart_item.dart';
import 'package:husbandman/src/cart/domain/usecase/fetch_cart.dart';
import 'package:husbandman/src/cart/domain/usecase/set_cart.dart';
import 'package:husbandman/src/cart/domain/usecase/update_item_quantity.dart';
import 'package:husbandman/src/cart/presentation/bloc/cart_bloc.dart';

final cartBlocProvider = Provider<CartBloc>((ref) {
  return CartBloc(
    ref.read(setCartProvider),
    ref.read(updateItemQuantityProvider),
    ref.read(deleteCartItemProvider),
    ref.read(deleteCartProvider),
    ref.read(fetchCartProvider),
  );
});

final cartDatasourceProvider = Provider<CartDatasource>(
  (ref) => CartDatasourceImpl(ref: ref),
);

final cartRepoProvider = Provider<CartRepo>(
  (ref) => CartRepoImpl(cartDatasource: ref.read(cartDatasourceProvider)),
);

final setCartProvider = Provider<SetCart>(
  (ref) => SetCart(
    cartRepo: ref.read(cartRepoProvider),
  ),
);

final updateItemQuantityProvider = Provider<UpdateItemQuantity>(
  (ref) => UpdateItemQuantity(
    cartRepo: ref.read(cartRepoProvider),
  ),
);

final deleteCartItemProvider = Provider<DeleteCartItem>(
  (ref) => DeleteCartItem(
    cartRepo: ref.read(cartRepoProvider),
  ),
);

final deleteCartProvider = Provider<DeleteCart>(
  (ref) => DeleteCart(
    cartRepo: ref.read(cartRepoProvider),
  ),
);

final fetchCartProvider = Provider<FetchCart>(
  (ref) => FetchCart(
    cartRepo: ref.read(cartRepoProvider),
  ),
);
