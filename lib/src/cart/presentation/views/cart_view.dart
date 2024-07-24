import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/src/cart/domain/entity/cart_entity.dart';
import 'package:husbandman/src/cart/data/model/cart_item.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/cart_provider.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/user_provider.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/common/widgets/snack_bar.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/services/injection/cart/cart_injection.dart';
import 'package:husbandman/src/cart/domain/entity/cart_item_entity.dart';
import 'package:husbandman/src/cart/presentation/bloc/cart_bloc.dart';
import 'package:husbandman/src/cart/presentation/widgets/order_summary.dart';
import 'package:numberpicker/numberpicker.dart';
final quantityProvider = StateProvider<int>((ref) => 1);

class CartView extends ConsumerStatefulWidget {
  const CartView({super.key});

  @override
  ConsumerState<CartView> createState() => _CartViewState();
}

class _CartViewState extends ConsumerState<CartView> {
  late CartBloc cartBloc;

  @override
  void initState() {
    cartBloc = ref.read(cartBlocProvider);
    final user = ref.read(userProvider).id;
    cartBloc.add(FetchCartEvent(ownerId: user));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);

    return BlocProvider(
      create: (context) => cartBloc,
      child: Scaffold(
        backgroundColor: HBMColors.coolGrey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const HBMTextWidget(data: 'In Cart'),
        ),
        body: BlocConsumer<CartBloc, CartState>(
          listener: (context, state) {
            if (state is FetchedCart) {
              log('Fetched cart..');
              cartBloc.add(SetCartEvent(cartEntity: state.cart));
            } else if (state is DeletedCartItem) {
              log('Delete item state response length: ${state.cart.items.length}');
              cartBloc.add(SetCartEvent(cartEntity: state.cart));
            } else if (state is CartSet) {
              log('Cart set successfully');
            } else if (state is CartError) {
              log('Something went wrong. Try again later ${state.message}');
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Expanded(child: _buildCartList(context, cart)),
                SizedBox(height: context.height * 0.03),
                OrderSummaryWidget(cart: cart),
                const SizedBox(height: 16),
                _buildBottomButtons(context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCartList(BuildContext context, CartEntity cart) {
    return ShaderMask(
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
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 0.05,
          vertical: context.height * 0.02,
        ),
        itemCount: cart.items.length,
        itemBuilder: (context, index) {
          final cartItem = cart.items[index];
          return CartItemWidget(cartItem: cartItem, ref: ref);
        },
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
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
    );
  }
}

class CartItemWidget extends StatelessWidget {

  const CartItemWidget({
    required this.cartItem,
    required this.ref,
    super.key,
  });
  final CartItemEntity cartItem;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
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
                  cartItem.productImage,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(child: _buildItemDetails(context)),
            SizedBox(width: context.width * 0.04),
          ],
        ),
      ),
    );
  }

  Widget _buildItemDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HBMTextWidget(
          data: cartItem.percentage.toString(),
          fontSize: context.width * 0.04,
          fontWeight: FontWeight.bold,
          fontFamily: HBMFonts.exoBold,
          color: HBMColors.coolGrey,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: context.height * 0.005),
        HBMTextWidget(
          data: 'Sold By: ${cartItem.sellerName}',
          color: HBMColors.coolGrey,
          overflow: TextOverflow.ellipsis,
          fontSize: context.width * 0.03,
        ),
        SizedBox(height: context.height * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HBMTextWidget(
              data: cartItem.productPrice.toString(),
              color: HBMColors.coolGrey,
              fontWeight: FontWeight.bold,
              fontSize: context.width * 0.04,
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.delete_outline_rounded),
                  onPressed: () {
                    context.read<CartBloc>().add(
                      DeleteCartItemEvent(
                        ownerId: ref.read(userProvider).id,
                        itemId: cartItem.id,
                      ),
                    );
                  },
                  color: HBMColors.coolGrey,
                ),
                SizedBox(width: context.width * 0.04),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    showQuantityPickerDialog(
                        cartItemId: cartItem.id, ref: ref, context: context);
                  },
                  icon: Wrap(
                    children: [
                      HBMTextWidget(
                        data: 'Qty: ${cartItem.productQuantity}',
                        color: HBMColors.coolGrey,
                        fontSize: context.width * 0.03,
                      ),
                      Icon(
                        Icons.arrow_drop_down_rounded,
                        color: HBMColors.coolGrey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

void showQuantityPickerDialog({
  required BuildContext context,
  required WidgetRef ref,
  required String cartItemId,
}) {
  showDialog<AlertDialog>(
    context: context,
    builder: (context) {
      final owner = ref.watch(userProvider);
      return BlocProvider(
        create: (context) => ref.read(cartBlocProvider),
        child: BlocConsumer<CartBloc, CartState>(
          listener: (context, state) {
            if (state is UpdatedItemQuantity) {
              context.read<CartBloc>().add(
                SetCartEvent(
                  cartEntity: state.cartItem,
                ),
              );
            } else if (state is CartSet) {
              Navigator.of(context).pop();
              HBMSnackBar.show(context: context, content: 'Quantity updated');
            }
          },
          builder: (context, state) {
            return Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  top: context.height * 0.23,
                  bottom: context.height * 0.27,
                ),
                child: AlertDialog(
                  title: Center(
                    child: HBMTextWidget(
                      data: 'Pick quantity',
                      fontSize: context.width * 0.05,
                    ),
                  ),
                  content: const QuantityPicker(),
                  backgroundColor: HBMColors.coolGrey,
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const HBMTextWidget(data: 'Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CartBloc>().add(
                          UpdateItemQuantityEvent(
                            quantity: ref.watch(quantityProvider),
                            ownerId: owner.id,
                            itemId: cartItemId,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HBMColors.mediumGrey,
                      ),
                      child: HBMTextWidget(
                        data: 'Save',
                        color: HBMColors.coolGrey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}

class QuantityPicker extends ConsumerStatefulWidget {
  const QuantityPicker({super.key});

  @override
  ConsumerState<QuantityPicker> createState() => _QuantityPickerState();
}

class _QuantityPickerState extends ConsumerState<QuantityPicker> {
  @override
  void didChangeDependencies() {
    ref.invalidate(quantityProvider);
    super.didChangeDependencies();
  }

  int newQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          NumberPicker(
            value: newQuantity,
            minValue: 0,
            maxValue: 100,
            itemHeight: context.height * 0.10,
            itemWidth: context.width * 0.15,
            axis: Axis.horizontal,
            onChanged: (value) {
              ref.read(quantityProvider.notifier).state = value.clamp(0, 50);
              setState(() => newQuantity = value.clamp(0, 50));
            },
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black26),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () => setState(() {
                  final newValue = newQuantity - 1;
                  newQuantity = newValue.clamp(0, 50);
                  ref.read(quantityProvider.notifier).state = newQuantity;
                }),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => setState(() {
                  final newValue = newQuantity + 1;
                  newQuantity = newValue.clamp(0, 50);
                  ref.read(quantityProvider.notifier).state = newQuantity;
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OrderSummaryWidget extends StatelessWidget {

  const OrderSummaryWidget({
    Key? key,
    required this.cart,
  }) : super(key: key);
  final CartEntity cart;

  @override
  Widget build(BuildContext context) {
    final orderItems = cart.items.take(3).map((item) {
      return OrderItem(
        name: item.productName,
        quantity: item.productQuantity,
        price: item.productPrice.toString(),
      );
    }).toList();

    final hiddenOrderItems = cart.items.length - orderItems.length;
    final totalPrice = cart.items.fold(0.0, (sum, item) {
      return sum +
          (double.tryParse(item.productPrice.toString()) ?? 0.0) *
              item.productQuantity;
    });

    return OrderSummary(
      hiddenItems: hiddenOrderItems,
      items: orderItems,
      total: '₦${totalPrice.toStringAsFixed(2)}',
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
