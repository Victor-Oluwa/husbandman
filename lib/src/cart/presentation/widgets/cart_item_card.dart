
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/models/cart/cart_item.dart';
import 'package:husbandman/core/common/app/provider/user_provider.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/src/cart/presentation/bloc/cart_bloc.dart';
import 'package:husbandman/src/cart/presentation/views/cart_view.dart';
import 'package:husbandman/src/cart/presentation/widgets/quantity_picker.dart';
class CartItemCard extends ConsumerWidget {
  const CartItemCard({
    required this.item,
    super.key,
  });

  final CartItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  item.productImage,
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
                    data: item.productName,
                    fontSize: context.width * 0.04,
                    fontWeight: FontWeight.bold,
                    fontFamily: HBMFonts.exoBold,
                    color: HBMColors.coolGrey,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: context.height * 0.005),
                  HBMTextWidget(
                    data: 'Sold By: ${item.sellerName}',
                    color: HBMColors.coolGrey,
                    overflow: TextOverflow.ellipsis,
                    fontSize: context.width * 0.03,
                  ),
                  SizedBox(height: context.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HBMTextWidget(
                        data: item.productPrice.toString(),
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
                                  ownerId: ref
                                      .read(userProvider)
                                      .id,
                                  itemId: item.id,
                                ),
                              );

                            },
                            color: HBMColors.coolGrey,
                          ),
                          SizedBox(
                            width: context.width * 0.04,
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: (){
                              showQuantityPickerDialog(cartItemId: item.id, ref: ref, context: context);
                            },
                            icon: Wrap(
                              children: [
                                HBMTextWidget(
                                  data: 'Qty: ${item.productQuantity}',
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
              ),
            ),
            SizedBox(width: context.width*0.04),
          ],
        ),
      ),
    );
  }
}
