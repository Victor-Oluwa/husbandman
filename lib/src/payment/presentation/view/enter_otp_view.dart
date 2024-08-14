import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/provider/argument_providers/card_funding_history_id_provider.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/common/widgets/snack_bar.dart';
import 'package:husbandman/core/enums/failure_stage.dart';
import 'package:husbandman/core/enums/funding_status.dart';
import 'package:husbandman/core/enums/history_updated_by.dart';
import 'package:husbandman/core/enums/update_card_funding_history.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/services/injection/payment/payment_injection.dart';
import 'package:husbandman/core/services/route_names.dart';
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
  HistoryUpdatedBy whoUpdatedHistory = HistoryUpdatedBy.init;
  String transactionId = 'none';
  String verificationStatus = '';

  // final submittedPinTheme =

  @override
  Widget build(BuildContext context) {
    final historyId = ref.watch(cardFundingHistoryIdProvider);
    return BlocProvider(
      create: (context) => ref.read(paymentBlocProvider),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: HBMColors.coolGrey,
        body: BlocConsumer<PaymentBloc, PaymentState>(
          listener: (context, state) {
            if (state is ValidatedCardFundingWithOtp) {
              _handleValidatedCardFundingWithOtp(context, state, historyId);
            } else if (state is UpdatedCardFundingHistory) {
              _handleUpdatedCardFundingHistory(context);
            } else if (state is VerifiedCardFunding) {
              _handleVerifiedCardFunding(state, historyId, context);
            } else if (state is PaymentHistoryError) {
              _handlePaymentHistoryError(context, state);
            } else if (state is PaymentError) {
              _handlePaymentError(context, state, historyId);
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                SizedBox(height: context.height * 0.15),
                HBMTextWidget(
                  data: 'Validation',
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

  void _handleValidatedCardFundingWithOtp(
    BuildContext context,
    ValidatedCardFundingWithOtp state,
    String historyId,
  ) {
    log('OTP Validated');
    setState(() {
      transactionId = state.transactionId;
      whoUpdatedHistory = HistoryUpdatedBy.bloc1;
    });

    context.read<PaymentBloc>().add(
          UpdateCardFundingHistoryEvent(
            historyId: historyId,
            values: [
              transactionId,
              DateTime.now().toIso8601String(),
            ],
            culprits: const [
              UpdateCardFundingHistoryCulprit.transactionId,
              UpdateCardFundingHistoryCulprit.date,
            ],
          ),
        );
  }

  void _handleUpdatedCardFundingHistory(BuildContext context) {
    switch (whoUpdatedHistory) {
      case HistoryUpdatedBy.bloc1:
        return _handleBloc1UpdatedHistory(context);
      case HistoryUpdatedBy.bloc2:
        return _handleBloc2UpdatedHistory(context);
      case HistoryUpdatedBy.bloc3:
        return _handleBloc3UpdatedHistory(context);
      default:
        return;
    }
  }

  void _handleBloc1UpdatedHistory(BuildContext context) {
    context.read<PaymentBloc>().add(
          CardFundingVerificationEvent(
            transactionId: transactionId,
          ),
        );
  }

  void _handleBloc2UpdatedHistory(BuildContext context) {
    final fundingStatus = fundingStatusMap[verificationStatus];

    switch (fundingStatus) {
      case FundingStatus.successful:
        Navigator.pushNamed(context, RouteNames.paymentSuccessfulViewWithArg);
        return;
      case FundingStatus.pending:
        Navigator.pushNamed(
          context,
          RouteNames.paymentSuccessfulViewWithArg,
          arguments: 'Pending',
        );
        return;
      case FundingStatus.failed:
        Navigator.pushNamed(
          context,
          RouteNames.paymentSuccessfulViewWithArg,
          arguments: 'Failed',
        );
        return;
      case null:
        Navigator.pushNamed(context, RouteNames.paymentSuccessfulViewWithArg,
            arguments: 'Failed',);
        return;
      case FundingStatus.none:
        Navigator.pushNamed(
          context,
          RouteNames.paymentSuccessfulViewWithArg,
          arguments: 'Failed',
        );
    }
  }

  void _handleBloc3UpdatedHistory(BuildContext context) {
    HBMSnackBar.show(
      context: context,
      content: 'Validation failed woefully',
    );
  }

  void _handleVerifiedCardFunding(
    VerifiedCardFunding state,
    String historyId,
    BuildContext context,
  ) {
    log('Transaction verified: ${state.status}');
    setState(() {
      whoUpdatedHistory = HistoryUpdatedBy.bloc2;
      verificationStatus = state.status;
    });

    final fundingStatus = fundingStatusMap[verificationStatus];
    context.read<PaymentBloc>().add(
          UpdateCardFundingHistoryEvent(
            historyId: historyId,
            values: [
              transactionId,
              verificationStatus,
              DateTime.now().toIso8601String(),
              if (fundingStatus == FundingStatus.failed)
                FailureStage.verification.name,
            ],
            culprits: [
              UpdateCardFundingHistoryCulprit.transactionId,
              UpdateCardFundingHistoryCulprit.fundingStatus,
              UpdateCardFundingHistoryCulprit.date,
              if (fundingStatus == FundingStatus.failed)
                UpdateCardFundingHistoryCulprit.failureStage,
            ],
          ),
        );
  }

  void _handlePaymentHistoryError(
    BuildContext context,
    PaymentHistoryError state,
  ) {
    log('EnterOTPView: Payment history error: ${state.message}');
    _showErrorSnackBar(context, 'Validation failed woefully');

    Future<void>.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteNames.dashboard,
        (Route<dynamic> route) => false,
      );
    });
    return;
  }

  void _handlePaymentError(
    BuildContext context,
    PaymentError state,
    String historyId,
  ) {
    log('EnterOTPView: OTP Validation error: ${state.message}');

    setState(() {
      whoUpdatedHistory = HistoryUpdatedBy.bloc3;
    });
    context.read<PaymentBloc>().add(
          UpdateCardFundingHistoryEvent(
            historyId: historyId,
            values: [
              FundingStatus.failed.name,
              transactionId,
              FailureStage.validation.name,
              state.message,
              DateTime.now().toIso8601String(),
            ],
            culprits: const [
              UpdateCardFundingHistoryCulprit.fundingStatus,
              UpdateCardFundingHistoryCulprit.transactionId,
              UpdateCardFundingHistoryCulprit.failureStage,
              UpdateCardFundingHistoryCulprit.failureMessage,
              UpdateCardFundingHistoryCulprit.date,
            ],
          ),
        );
  }

  void _showErrorSnackBar(BuildContext context, String content) {
    HBMSnackBar.show(
      context: context,
      content: content,
    );
  }

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
}
