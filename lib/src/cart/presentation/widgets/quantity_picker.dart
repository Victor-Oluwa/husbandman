import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/models/cart/cart_model.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/user_provider.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/common/widgets/snack_bar.dart';
import 'package:husbandman/core/enums/set_cart_type.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/services/injection/cart/cart_injection.dart';
import 'package:husbandman/src/cart/presentation/bloc/cart_bloc.dart';
import 'package:numberpicker/numberpicker.dart';

final quantityProvider = StateProvider<int>((ref) => 1);

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
          // SizedBox(height: context.height * 0.04),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () => setState(() {
                  final newValue = newQuantity - 1;
                  newQuantity = newValue.clamp(0, 50);
                  ref.read(quantityProvider.notifier).state = newQuantity;
                }),
              ),
              IconButton(
                icon: Icon(Icons.add),
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

void showQuantityPickerDialog({
  required BuildContext context,
  required WidgetRef ref,
  required String cartItemId,
}) {
  showDialog<AlertDialog>(
    context: context,
    builder: (context) {
      final quantity = ref.watch(quantityProvider);
      final owner = ref.watch(userProvider);
      return BlocProvider(
        create: (context) => ref.read(cartBlocProvider),
        child: BlocConsumer<CartBloc, CartState>(
          listener: (context, state) {
            if (state is UpdatedItemQuantity) {
              final cart = state.cartItem as CartModel;
              context.read<CartBloc>().add(
                    SetCartEvent(
                      setCartType: SetCartType.updateCart,
                      pNewCartModel: cart,
                    ),
                  );
            }

            if (state is CartSet) {
              Navigator.of(context).pop();
              HBMSnackBar.show(context: context, content: 'Quantity updated');
            }
          },
          builder: (context, state) {
            return Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(
                    top: context.height * 0.23, bottom: context.height * 0.27),
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
                      child: HBMTextWidget(data: 'Cancel'),
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
                          backgroundColor: HBMColors.mediumGrey),
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
