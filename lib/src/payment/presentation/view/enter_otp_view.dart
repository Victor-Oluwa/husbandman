import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/services/injection/payment/payment_injection.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/payment/presentation/bloc/payment_bloc.dart';
import 'package:pinput/pinput.dart';

class EnterOTPView extends ConsumerStatefulWidget {
  const EnterOTPView({
    required this.ref,
    required this.otpMessage,
    required this.transactionId,
    super.key,
  });

  final String? ref;
  final String? otpMessage;
  final String? transactionId;

  @override
  ConsumerState<EnterOTPView> createState() => _EnterOTPViewState();
}

class _EnterOTPViewState extends ConsumerState<EnterOTPView> {
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
            if (state is ValidatedCardFundingWithOtp) {
              log('OTP Validated');
              log('Transaction ID from OTP: ${state.transactionId}');
              context.read<PaymentBloc>().add(
                    CardFundingVerificationEvent(
                      transactionId: state.transactionId,
                    ),
                  );
            }

            if(state is VerifiedCardFunding){
              Navigator.pushNamed(
                context,
                RouteNames.paymentSuccessfulViewWithArg,
              );
            }

            if (state is PaymentError) {
              log('OTP Validation error: ${state.message}');
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
                SizedBox(height: context.height * 0.02),
                HBMTextWidget(
                  textAlign: TextAlign.center,
                  data: widget.otpMessage ??
                      'Kindly input the was sent to your '
                          'mobile number',
                ),
                SizedBox(height: context.height * 0.10),
                Center(
                  child: Pinput(
                    length: 5,
                    defaultPinTheme: defaultPinTheme(context),
                    focusedPinTheme: focusedPinTheme(context),
                    submittedPinTheme: submittedPinTheme(context),
                    onCompleted: (otp) {
                      context.read<PaymentBloc>().add(
                            CardFundingOtpValidationEvent(
                              otp: otp,
                              ref: widget.ref ?? 'lol',
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
