import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/provider/argument_providers/card_funding_history_id_provider.dart';
import 'package:husbandman/core/common/widgets/bread_text_field.dart';
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
import 'package:husbandman/src/payment/domain/entity/card_funding_address_auth_response_entity.dart';
import 'package:husbandman/src/payment/presentation/bloc/payment_bloc.dart';

class EnterCardAddressView extends ConsumerStatefulWidget {
  const EnterCardAddressView({required this.payload, super.key});

  final DataMap payload;

  @override
  ConsumerState<EnterCardAddressView> createState() =>
      _EnterCardAddressViewState();
}

class _EnterCardAddressViewState extends ConsumerState<EnterCardAddressView> {
  CardFundingAddressAuthResponseEntity authenticateFundingResponse =
      const CardFundingAddressAuthResponseEntity.empty();
  String verificationStatus = '';

  HistoryUpdatedBy whoUpdatedHistory = HistoryUpdatedBy.init;
  final _formKey = GlobalKey<FormState>();

  late PaymentBloc _paymentBloc;

  late TextEditingController _cityController;
  late TextEditingController _streetController;
  late TextEditingController _stateController;
  late TextEditingController _countryController;
  late TextEditingController _zipcodeController;

  @override
  void initState() {
    _paymentBloc = ref.read(paymentBlocProvider);
    _cityController = TextEditingController();
    _streetController = TextEditingController();
    _stateController = TextEditingController();
    _countryController = TextEditingController();
    _zipcodeController = TextEditingController();

    super.initState();
  }

  String? _validateField(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  @override
  void dispose() {
    _paymentBloc.close();
    _zipcodeController.dispose();
    _countryController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    _streetController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      _paymentBloc.add(
        CardFundingAddressAuthEvent(
          payload: widget.payload,
          address: _streetController.text,
          city: _cityController.text,
          state: _stateController.text,
          country: _countryController.text,
          zipCode: _zipcodeController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final historyId = ref.watch(cardFundingHistoryIdProvider);
    return BlocProvider(
      create: (context) => ref.read(paymentBlocProvider),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _onSubmit,
          child: const Icon(Icons.done_all),
        ),
        backgroundColor: HBMColors.coolGrey,
        body: BlocConsumer<PaymentBloc, PaymentState>(
          listener: (context, state) {
            if (state is AuthorizedCardFundingWithAddress) {
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

            if (state is PaymentError) {
              HBMSnackBar.show(
                context: context,
                content: 'Failed to authenticate with address'
                    ' Try again later',
              );
              log('Failed to authenticate with address'
                  ' Try again later');
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(height: context.height * 0.15),
                      HBMTextWidget(
                        data: 'Authentication',
                        fontSize: context.width * 0.08,
                      ),
                      SizedBox(height: context.height * 0.05),
                      const HBMTextWidget(
                          textAlign: TextAlign.center,
                          data:
                              'Kindly enter your address to authenticate this transaction',),
                      SizedBox(height: context.height * 0.05),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.width * 0.05,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              BreadTextField(
                                fieldController: _cityController,
                                cursorColor: HBMColors.mediumGrey,
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HBMColors.mediumGrey),
                                  borderRadius: BorderRadius.circular(
                                      context.width * 0.03,),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HBMColors.charcoalGrey),
                                  borderRadius: BorderRadius.circular(
                                      context.width * 0.02,),
                                ),
                                hintText: 'City',
                                hintStyle: TextStyle(
                                  fontFamily: HBMFonts.quicksandNormal,
                                  color: HBMColors.grey,
                                ),
                                textStyle: TextStyle(
                                    fontFamily: HBMFonts.quicksandNormal,),
                                icon: Icon(
                                  Icons.location_city,
                                  color: HBMColors.charcoalGrey,
                                ),
                                validator: _validateField,
                              ),
                              SizedBox(height: context.height * 0.01),
                              BreadTextField(
                                fieldController: _streetController,
                                cursorColor: HBMColors.mediumGrey,
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HBMColors.mediumGrey),
                                  borderRadius: BorderRadius.circular(
                                      context.width * 0.03,),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HBMColors.charcoalGrey),
                                  borderRadius: BorderRadius.circular(
                                      context.width * 0.02,),
                                ),
                                hintText: 'Street',
                                hintStyle: TextStyle(
                                  fontFamily: HBMFonts.quicksandNormal,
                                  color: HBMColors.grey,
                                ),
                                textStyle: TextStyle(
                                    fontFamily: HBMFonts.quicksandNormal,),
                                icon: Icon(
                                  Icons.streetview_rounded,
                                  color: HBMColors.charcoalGrey,
                                ),
                                validator: _validateField,
                              ),
                              SizedBox(height: context.height * 0.01),
                              BreadTextField(
                                fieldController: _stateController,
                                cursorColor: HBMColors.mediumGrey,
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HBMColors.mediumGrey),
                                  borderRadius: BorderRadius.circular(
                                      context.width * 0.03,),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HBMColors.charcoalGrey),
                                  borderRadius: BorderRadius.circular(
                                      context.width * 0.02,),
                                ),
                                hintText: 'State',
                                hintStyle: TextStyle(
                                  fontFamily: HBMFonts.quicksandNormal,
                                  color: HBMColors.grey,
                                ),
                                textStyle: TextStyle(
                                    fontFamily: HBMFonts.quicksandNormal,),
                                icon: Icon(
                                  Icons.location_searching,
                                  color: HBMColors.charcoalGrey,
                                ),
                                validator: _validateField,
                              ),
                              SizedBox(height: context.height * 0.01),
                              BreadTextField(
                                fieldController: _countryController,
                                cursorColor: HBMColors.mediumGrey,
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HBMColors.mediumGrey),
                                  borderRadius: BorderRadius.circular(
                                      context.width * 0.03,),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HBMColors.charcoalGrey),
                                  borderRadius: BorderRadius.circular(
                                      context.width * 0.02,),
                                ),
                                hintText: 'Country',
                                hintStyle: TextStyle(
                                  fontFamily: HBMFonts.quicksandNormal,
                                  color: HBMColors.grey,
                                ),
                                textStyle: TextStyle(
                                    fontFamily: HBMFonts.quicksandNormal,),
                                icon: Icon(
                                  Icons.map,
                                  color: HBMColors.charcoalGrey,
                                ),
                                validator: _validateField,
                              ),
                              SizedBox(height: context.height * 0.01),
                              BreadTextField(
                                fieldController: _zipcodeController,
                                cursorColor: HBMColors.mediumGrey,
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HBMColors.mediumGrey),
                                  borderRadius: BorderRadius.circular(
                                      context.width * 0.03,),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HBMColors.charcoalGrey),
                                  borderRadius: BorderRadius.circular(
                                      context.width * 0.02,),
                                ),
                                hintText: 'Zipcode',
                                hintStyle: TextStyle(
                                  fontFamily: HBMFonts.quicksandNormal,
                                  color: HBMColors.grey,
                                ),
                                textStyle: TextStyle(
                                    fontFamily: HBMFonts.quicksandNormal,),
                                icon: Icon(
                                  Icons.my_location_rounded,
                                  color: HBMColors.charcoalGrey,
                                ),
                                validator: _validateField,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: context.height * 0.01),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleAuthorizedCardFundingWithPin(
    BuildContext context,
    AuthorizedCardFundingWithAddress state,
    String historyId,
  ) {
    log('Address Authorised: ${state.response}');

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
          content: 'Failed to authenticate with transaction. Try again later',
        );
    }
  }

  void _handleBloc2UpdatedHistory(BuildContext context) {
    log('Validation Updated history');
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
    Navigator.pushNamed(
      context,
      RouteNames.paymentSuccessfulViewWithArg,
      arguments: 'Failed',
    );
    return;
  }

  void _handleVerifiedCardFunding(
    BuildContext context,
    VerifiedCardFunding state,
    String historyId,
  ) {
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
      BuildContext context, PaymentHistoryError state,) {
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
    BuildContext context,
    PaymentError state,
    String historyId,
  ) {
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
