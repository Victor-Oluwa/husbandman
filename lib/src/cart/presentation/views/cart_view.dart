import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/models/cart/cart_model.dart';
import 'package:husbandman/core/common/app/provider/general_product_provider.dart';
import 'package:husbandman/core/common/app/provider/category_product_provider.dart';
import 'package:husbandman/core/common/app/provider/user_provider.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/common/widgets/snack_bar.dart';
import 'package:husbandman/core/enums/set_cart_type.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/src/cart/presentation/bloc/cart_bloc.dart';
import 'package:husbandman/src/product_manager/presentation/bloc/product_manager_bloc.dart';

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
    return BlocListener<ProductManagerBloc, ProductManagerState>(
      listener: (context, state) {
        if (state is CartSet) {
          log('Cart set successfully');
        }

        if (state is ProductManagerError) {
          HBMSnackBar.show(
            context: context,
            content: 'Something went wrong. Try again later',
          );
        }
      },
      child: BlocConsumer<CartBloc, CartState>(
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

          if (state is CartError) {
            HBMSnackBar.show(
              context: context,
              content: 'Something went wrong. Try again later',
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: HBMColors.coolGrey,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const HBMTextWidget(data: 'In Cart'),
            ),
            body: Padding(
              padding: EdgeInsets.only(
                left: context.width * 0.05,
                right: context.width * 0.05,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        CartItem(
                          imageUrl:
                              ref.read(generalProductProvider)[0].images[0],
                          title: 'Flower Pots for Living Room',
                          seller: 'The Decor Circle',
                          price: '₹8,500.00',
                          quantity: 1,
                        ),
                        CartItem(
                          imageUrl:
                              ref.read(generalProductProvider)[0].images[0],
                          title: 'Flower Pots for Living Room',
                          seller: 'The Decor Circle',
                          price: '₹8,500.00',
                          quantity: 1,
                        ),
                        CartItem(
                          imageUrl:
                              ref.read(generalProductProvider)[0].images[0],
                          title: 'Flower Pots for Living Room',
                          seller: 'The Decor Circle',
                          price: '₹8,500.00',
                          quantity: 1,
                        ),
                        CartItem(
                          imageUrl:
                              ref.read(generalProductProvider)[0].images[0],
                          title: 'Flower Pots for Living Room',
                          seller: 'The Decor Circle',
                          price: '₹8,500.00',
                          quantity: 1,
                        ),
                      ],
                    ),
                  ),
                  OrderSummary(
                    items: [
                      OrderItem(
                          name: 'Flower Pots for Living Room',
                          quantity: 1,
                          price: '₦8,500'),
                      OrderItem(
                          name: 'Decorative Wall Mirror',
                          quantity: 1,
                          price: '₦2,150'),
                      OrderItem(
                          name: 'Corsica - Wall Clock',
                          quantity: 1,
                          price: '₹479'),
                    ],
                    total: '₦11,129',
                  ),
                  SizedBox(height: 16),
                  Row(
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
                        onPressed: () {},
                        child: HBMTextWidget(
                            data: 'CHECKOUT', color: HBMColors.coolGrey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String seller;
  final String price;
  final int quantity;

  const CartItem({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.seller,
    required this.price,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: HBMColors.mediumGrey,
      margin: EdgeInsets.symmetric(vertical: context.height * 0.01),
      child: Padding(
        padding: EdgeInsets.all(context.width * 0.02),
        child: Row(
          children: [
            SizedBox(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(context.width * 0.02),
                child: Image.network(
                  imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HBMTextWidget(
                    data: title,
                    fontSize: context.width * 0.04,
                    fontWeight: FontWeight.bold,
                    fontFamily: HBMFonts.exoBold,
                    color: HBMColors.coolGrey,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: context.height * 0.005),
                  HBMTextWidget(
                    data: 'Sold By: $seller',
                    color: HBMColors.coolGrey,
                    overflow: TextOverflow.ellipsis,
                    fontSize: context.width * 0.03,
                  ),
                  SizedBox(height: context.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HBMTextWidget(
                        data: price,
                        color: HBMColors.coolGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: context.width * 0.04,
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(Icons.delete_outline_rounded,
                              color: HBMColors.coolGrey),
                          SizedBox(
                            width: context.width * 0.04,
                          ),
                          HBMTextWidget(
                            data: 'Qty: $quantity',
                            color: HBMColors.coolGrey,
                            fontSize: context.width * 0.03,
                          ),
                          Icon(
                            Icons.arrow_drop_down_rounded,
                            color: HBMColors.coolGrey,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}

class OrderSummary extends StatelessWidget {
  final List<OrderItem> items;
  final String total;

  const OrderSummary({
    Key? key,
    required this.items,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: HBMColors.charcoalGrey,
      child: Padding(
        padding: EdgeInsets.all(context.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HBMTextWidget(
              data: 'Order Summary:',
              color: HBMColors.coolGrey,
              fontSize: context.width * 0.04,
              fontFamily: HBMFonts.exoBold,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 8),
            Column(
              children: items.map((item) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: context.height * 0.005),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: context.width * 0.40,
                        child: HBMTextWidget(
                          data: '${item.name}',
                          overflow: TextOverflow.ellipsis,
                          color: HBMColors.coolGrey,
                          fontSize: context.width * 0.03,
                        ),
                      ),
                      HBMTextWidget(
                        data: 'Qty: ${item.quantity}:',
                        color: HBMColors.coolGrey,
                        fontSize: context.width * 0.03,
                      ),
                      SizedBox(
                        width: context.width * 0.20,
                        child: HBMTextWidget(
                          data: '${item.price}',
                          color: HBMColors.coolGrey,
                          fontSize: context.width * 0.03,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            Center(
              child: HBMTextWidget(
                data: '10 more',
                fontSize: context.width * 0.03,
                color: HBMColors.grey,
              ),
            ),
            SizedBox(height: context.height * 0.01),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HBMTextWidget(
                  data: 'Total:',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: HBMColors.coolGrey,
                ),
                SizedBox(
                  width: context.width * 0.02,
                ),
                HBMTextWidget(
                  data: total,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: HBMColors.coolGrey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OrderItem {
  final String name;
  final int quantity;
  final String price;

  OrderItem({
    required this.name,
    required this.quantity,
    required this.price,
  });
}
