import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/models/cart/cart_item.dart';
import 'package:husbandman/core/common/app/models/cart/cart_model.dart';
import 'package:husbandman/core/common/app/provider/cart_provider.dart';
import 'package:husbandman/core/common/app/provider/user_provider.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/enums/set_cart_type.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:husbandman/src/cart/presentation/bloc/cart_bloc.dart';
import 'package:husbandman/src/cart/presentation/widgets/cart_item_card.dart';
import 'package:husbandman/src/cart/presentation/widgets/order_summary.dart';
import 'package:husbandman/src/cart/presentation/widgets/quantity_picker.dart';

class CartView extends ConsumerStatefulWidget {
  const CartView({super.key});

  @override
  ConsumerState<CartView> createState() => _CartViewState();
}

class _CartViewState extends ConsumerState<CartView> {
  @override
  void initState() {
    final user = ref.read(userProvider).id;
    context.read<CartBloc>().add(FetchCartEvent(ownerId: user));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    // Extract the first three items from the cart
    final orderItems = cart.items.take(3).map((item) {
      return OrderItem(
        name: item.productName,
        quantity: item.productQuantity,
        price: item.productPrice.toString(),
      );
    }).toList();

    final hiddenOrderItems = cart.items.length - orderItems.length;

    // Calculate the total price of all items in the cart
    final totalPrice = cart.items.fold(0.0, (sum, item) {
      return sum +
          (double.tryParse(item.productPrice.toString()) ?? 0.0) *
              item.productQuantity;
    });

    return Scaffold(
      backgroundColor: HBMColors.coolGrey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const HBMTextWidget(data: 'In Cart'),
      ),
      body: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state is FetchedCart) {
            log('Fetched cart..');
            final cart = state.cart as CartModel;
            context.read<CartBloc>().add(
                  SetCartEvent(
                    setCartType: SetCartType.updateCart,
                    pNewCartModel: cart,
                  ),
                );
          }

          if (state is DeletedCartItem) {
            log('Delete item state response lent: ${state.cart.items.length}');
            final cartModel = state.cart as CartModel;
            context.read<CartBloc>().add(
                  SetCartEvent(
                    setCartType: SetCartType.updateCart,
                    pNewCartModel: cartModel,
                  ),
                );
          }

          if (state is CartSet) {
            log('Cart set successfully');
          }

          if (state is CartError) {
            log('Something went wrong. Try again later ${state.message}');
          }
        },
        child: Column(
          children: [
            Expanded(
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, HBMColors.coolGrey],
                    stops: const [0.7, 1.0],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstOut,
                child: ListView.builder(
                  padding: EdgeInsets.only(
                    bottom: context.height * 0.04,
                    left: context.width * 0.05,
                    right: context.width * 0.05,
                  ),
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final cartItem = cart.items[index];
                    return CartItemCard(
                      item: cartItem,
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: context.height * 0.03),
            Padding(
              padding: EdgeInsets.only(
                left: context.width * 0.02,
                right: context.width * 0.02,
              ),
              child: OrderSummary(
                hiddenItems: hiddenOrderItems,
                items: orderItems,
                total:
                    '₦${totalPrice.toStringAsFixed(2)}', // Display the total price of all items
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.only(
                left: context.width * 0.04,
                right: context.width * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: HBMTextWidget(
                      data: 'Continue Shopping',
                      color: HBMColors.charcoalGrey,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HBMColors.charcoalGrey,
                    ),
                    onPressed: () {
                      // Navigator.pushNamed(context, RouteNames.testWidgetView);
                    },
                    child: HBMTextWidget(
                      data: 'CHECKOUT',
                      color: HBMColors.coolGrey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderItem {
  OrderItem({
    required this.name,
    required this.quantity,
    required this.price,
  });

  final String name;
  final int quantity;
  final String price;
}
