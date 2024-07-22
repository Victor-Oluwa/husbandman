import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/provider/argument_providers/card_funding_history_id_provider.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/common/widgets/snack_bar.dart';
import 'package:husbandman/core/enums/card_auth_type.dart';
import 'package:husbandman/core/enums/failure_stage.dart';
import 'package:husbandman/core/enums/funding_status.dart';
import 'package:husbandman/core/enums/history_updated_by.dart';
import 'package:husbandman/core/enums/update_card_funding_history.dart';
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
  HistoryUpdatedBy whoUpdatedHistory = HistoryUpdatedBy.init;
  String verificationStatus = '';
  CardFundingPinAuthResponseEntity authenticateFundingResponse =
      const CardFundingPinAuthResponseEntity.empty();

  @override
  Widget build(BuildContext context) {
    final historyId = ref.watch(cardFundingHistoryIdProvider);
    log('ID 2: $historyId');
    log('TransactionId: ${authenticateFundingResponse.transactionId}');

    return BlocProvider(
      create: (context) => ref.read(paymentBlocProvider),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: HBMColors.coolGrey,
        body: BlocConsumer<PaymentBloc, PaymentState>(
          listener: (context, state) {
            if (state is AuthorizedCardFundingWithPin) {
              _handleAuthorizedCardFundingWithPin(context, state, historyId);
            } else if (state is UpdatedCardFundingHistory) {
              _handleUpdatedCardFundingHistory(context);
            } else if (state is VerifiedCardFunding) {
              _handleVerifiedCardFunding(context, state, historyId);
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

  void _handleAuthorizedCardFundingWithPin(BuildContext context,
      AuthorizedCardFundingWithPin state, String historyId) {
    log('Pin Authorised: ${state.response}');
    setState(() {
      authenticateFundingResponse = state.response;
      whoUpdatedHistory = HistoryUpdatedBy.bloc1;
    });
    context.read<PaymentBloc>().add(
          UpdateCardFundingHistoryEvent(
            historyId: historyId,
            values: [
              authenticateFundingResponse.transactionId ?? 'none',
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
    log('Written History');
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
    log('Bloc1 Updated history');
    final responseEnum =
        cardFundingValidationTypeEnumMap[authenticateFundingResponse.message];
    switch (responseEnum) {
      case CardFundingValidationTypeEnum.otp:
        Navigator.pushNamed(
          context,
          RouteNames.enterOTPViewWithArgs,
          arguments: authenticateFundingResponse,
        );
        return;
      case CardFundingValidationTypeEnum.redirect:
        Navigator.pushNamed(
          context,
          RouteNames.breadBrowserViewWithArgs,
          arguments: authenticateFundingResponse,
        );
        return;
      case CardFundingValidationTypeEnum.verify:
        context.read<PaymentBloc>().add(
              CardFundingVerificationEvent(
                transactionId: authenticateFundingResponse.transactionId ?? '',
              ),
            );
        return;
      case null:
        HBMSnackBar.show(
          context: context,
          content: 'Failed to authenticate transaction. Try again later',
        );
        return;
    }
  }

  void _handleBloc2UpdatedHistory(BuildContext context) {
    log('Bloc2 Updated history');
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
          arguments: 'Declined',
        );
        return;
      case null:
        Navigator.pushNamed(context, RouteNames.paymentSuccessfulViewWithArg,
            arguments: 'Declined');
        return;
      case FundingStatus.none:
        Navigator.pushNamed(
          context,
          RouteNames.paymentSuccessfulViewWithArg,
          arguments: 'Declined',
        );
    }
  }

  void _handleBloc3UpdatedHistory(BuildContext context) {
    Navigator.pushNamed(
      context,
      RouteNames.paymentSuccessfulViewWithArg,
      arguments: 'Declined',
    );
    return;
  }

  void _handleVerifiedCardFunding(
      BuildContext context, VerifiedCardFunding state, String historyId) {
    log('Funding Verified: ${state.status}');
    setState(() {
      whoUpdatedHistory = HistoryUpdatedBy.bloc2;
      verificationStatus = state.status;
    });
    final fundingStatus = fundingStatusMap[verificationStatus];
    context.read<PaymentBloc>().add(
          UpdateCardFundingHistoryEvent(
            historyId: historyId,
            values: [
              authenticateFundingResponse.transactionId ?? 'none',
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
      BuildContext context, PaymentHistoryError state) {
    log('Update History Error: ${state.message}');
    HBMSnackBar.show(
      context: context,
      content: 'Failed to authenticate transaction',
    );
    Future<void>.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RouteNames.dashboard,
          (Route<dynamic> route) => false,
        );
      },
    );
  }

  void _handlePaymentError(
      BuildContext context, PaymentError state, String historyId) {
    log('Payment Error: ${state.message}');
    setState(() {
      whoUpdatedHistory = HistoryUpdatedBy.bloc3;
    });
    context.read<PaymentBloc>().add(
          UpdateCardFundingHistoryEvent(
            historyId: historyId,
            values: [
              FundingStatus.failed.name,
              authenticateFundingResponse.transactionId ?? 'none',
              FailureStage.authentication.name,
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
