import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/common/widgets/snack_bar.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/services/injection/payment/payment_injection.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/payment/domain/entity/card_funding_pin_auth_response_entity.dart';
import 'package:husbandman/src/payment/presentation/bloc/payment_bloc.dart';
import 'package:pinput/pinput.dart';

class EnterCardPinView extends ConsumerStatefulWidget {
  const EnterCardPinView({required this.payload, super.key});

  final DataMap payload;

  @override
  ConsumerState<EnterCardPinView> createState() => _EnterCardPinViewState();
}

class _EnterCardPinViewState extends ConsumerState<EnterCardPinView> {
  PinTheme defaultPinTheme(BuildContext context) {
    return PinTheme(
      width: context.width * 0.15,
      height: context.height * 0.09,
      textStyle: TextStyle(
        fontSize: context.width * 0.06,
        color: HBMColors.charcoalGrey,
        fontFamily: HBMFonts.quicksandNormal,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: HBMColors.charcoalGrey),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  PinTheme focusedPinTheme(BuildContext context) {
    return PinTheme(
      width: context.width * 0.15,
      height: context.height * 0.09,
      textStyle: TextStyle(
        fontSize: context.width * 0.06,
        color: HBMColors.charcoalGrey,
        fontFamily: HBMFonts.quicksandNormal,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: HBMColors.charcoalGrey),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  PinTheme submittedPinTheme(BuildContext context) {
    return PinTheme(
      width: context.width * 0.15,
      height: context.height * 0.09,
      textStyle: TextStyle(
        fontSize: context.width * 0.06,
        color: HBMColors.coolGrey,
        fontFamily: HBMFonts.quicksandNormal,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: HBMColors.grey,
        border: Border.all(color: HBMColors.charcoalGrey),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  // final submittedPinTheme =

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ref.read(paymentBlocProvider),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: HBMColors.coolGrey,
        body: BlocConsumer<PaymentBloc, PaymentState>(
          listener: (context, state) {
            if (state is AuthorizedCardFundingWithPin) {
              log('Pin Authorised: ${state.response}');
              final response = state.response;
              switch (response.message) {
                case 'otp':
                  Navigator.pushNamed(
                    context,
                    RouteNames.enterOTPViewWithArgs,
                    arguments: response,
                  );

                case 'redirect':
                  Navigator.pushNamed(
                    context,
                    RouteNames.breadBrowserViewWithArgs,
                    arguments: response,
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
                    content: 'Authorisation failed',
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
              log('Pin Auth Error: ${state.message}');
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                SizedBox(height: context.height * 0.15),
                HBMTextWidget(
                  data: 'Authentication',
                  fontSize: context.width * 0.08,
                ),
                HBMTextWidget(data: 'Enter your card pin'),
                SizedBox(height: context.height * 0.10),
                Center(
                  child: Pinput(
                    defaultPinTheme: defaultPinTheme(context),
                    focusedPinTheme: focusedPinTheme(context),
                    submittedPinTheme: submittedPinTheme(context),
                    onCompleted: (pin) {
                      context.read<PaymentBloc>().add(
                            CardFundingPinAuthEvent(
                              pin: pin,
                              payload: widget.payload,
                            ),
                          );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
