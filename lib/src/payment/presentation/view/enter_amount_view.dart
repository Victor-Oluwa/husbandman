import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/provider/argument_providers/selected_payment_card_provider.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/payment_card_provider.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/user_provider.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/common/widgets/snack_bar.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/services/injection/payment/payment_injection.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:husbandman/src/payment/presentation/bloc/payment_bloc.dart';

class EnterAmountView extends ConsumerStatefulWidget {
  const EnterAmountView({super.key});

  @override
  ConsumerState<EnterAmountView> createState() => _EnterAmountViewState();
}

class _EnterAmountViewState extends ConsumerState<EnterAmountView> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    _controller = TextEditingController();
    _focusNode = FocusNode();

    // Ensure the focus node is always focused
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final card = ref.watch(selectedPaymentCardProvider);
    return BlocProvider(
      create: (context) => ref.read(paymentBlocProvider),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: HBMColors.coolGrey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const HBMTextWidget(
            data: 'Enter Amount',
          ),
        ),
        body: BlocConsumer<PaymentBloc, PaymentState>(
          listener: (context, state) {
            if (state is InitializedCardFunding) {
              log('Payment Initialized');
              final response = state.response;
              switch (response.message) {
                case 'PIN required':
                  Navigator.pushNamed(
                    context,
                    RouteNames.enterCardPinViewWIthArgs,
                    arguments: response.payload,
                  );
                case 'Redirecting':
                  Navigator.pushNamed(
                    context,
                    RouteNames.breadBrowserViewWithArgs,
                    arguments: response,
                  );
                case 'Address required':
                  Navigator.pushNamed(
                    context,
                    RouteNames.enterCardAddressView,
                    arguments: response.payload,
                  );
                case 'verify':
                  context.read<PaymentBloc>().add(
                        CardFundingVerificationEvent(
                          transactionId: response.transactionId ?? '',
                        ),
                      );
                default:
                  HBMSnackBar.show(
                    context: context,
                    content: 'Failed to initialize transaction. '
                        'Please try again later',
                  );
              }
            }

            if (state is VerifiedCardFunding) {
              Navigator.pushNamed(
                context,
                RouteNames.paymentSuccessfulViewWithArg,
              );
            }
            if (state is PaymentError) {
              log('Init Payment Error: ${state.message}');
              HBMSnackBar.show(
                context: context,
                content: 'Failed to initialize transaction. '
                    'Please try again later',
              );
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: context.height * 0.09),
                  child: TextField(
                    focusNode: _focusNode,
                    controller: _controller,
                    cursorColor: HBMColors.mediumGrey,
                    style: TextStyle(
                      fontSize: context.width * 0.15,
                    ),
                    onChanged: (text) {
                      setState(() {});
                    },
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '0.00',
                      alignLabelWithHint: true,
                      hintStyle: TextStyle(
                        fontFamily: HBMFonts.exo2,
                        fontSize: context.width * 0.15,
                        color: HBMColors.grey,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: context.height * 0.04),
                  child: TextButton(
                    onPressed: () {
                      if (_controller.text.isEmpty ||
                          double.parse(_controller.text) < 1) {
                        HBMSnackBar.show(
                            context: context,
                            content: 'Please enter a valid amount');
                        return;
                      }
                      if (card == null) {
                        HBMSnackBar.show(
                            context: context, content: 'No card was selected');
                        return;
                      }

                      context.read<PaymentBloc>().add(
                            InitializeCardFundingEvent(
                              cardNumber: card.number.replaceAll(' ', ''),
                              cvv: card.ccv,
                              expiryYear: card.expiryDate.substring(3, 5),
                              expiryMonth: card.expiryDate.substring(0, 2),
                              currency: 'NGN',
                              amount: _controller.text,
                              redirectUrl: 'www.google.com',
                              fullName: card.holderName,
                              email: 'gm.oluwafemi@gmail.com',
                              phone: '07058919193',
                              ref: DateTime.now()
                                  .microsecondsSinceEpoch
                                  .toString(),
                            ),
                          );
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: _controller.text.isNotEmpty
                            ? HBMColors.charcoalGrey
                            : HBMColors.grey,
                        fixedSize:
                            Size(context.width * 0.80, context.height * 0.06)),
                    child: HBMTextWidget(
                      data: 'Continue',
                      color: HBMColors.coolGrey,
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
