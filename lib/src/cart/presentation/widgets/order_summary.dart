import 'package:flutter/material.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/src/cart/presentation/views/cart_view.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    required this.items,
    required this.total,
    required this.hiddenItems,
    super.key,
  });
  final List<OrderItem> items;
  final String total;
  final int hiddenItems;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
        left: context.width * 0.02,
        right: context.width * 0.02,),
      child: Card(
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
              const SizedBox(height: 8),
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
                            data: item.name,
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
                            data: item.price,
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
                  data: hiddenItems >=0 ? '$hiddenItems more': '',
                  fontSize: context.width * 0.03,
                  color: HBMColors.grey,
                ),
              ),
              SizedBox(height: context.height * 0.01),
              const Divider(),
              Row(
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
      ),
    );
  }
}
