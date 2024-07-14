import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/widgets/bread_text_field.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/common/widgets/snack_bar.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/services/injection/payment/payment_injection.dart';
import 'package:husbandman/core/services/route_names.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/payment/presentation/bloc/payment_bloc.dart';

class EnterCardAddressView extends ConsumerStatefulWidget {
  const EnterCardAddressView({required this.payload, super.key});

  final DataMap payload;

  @override
  ConsumerState<EnterCardAddressView> createState() =>
      _EnterCardAddressViewState();
}

class _EnterCardAddressViewState extends ConsumerState<EnterCardAddressView> {
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
              log('Authorised With Address: ${state.response}');
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
                    content: 'Failed to authenticate with address'
                        ' Try again later',
                  );
              }
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
                              'Kindly enter your address to authenticate this transaction'),
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
                                      context.width * 0.03),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HBMColors.charcoalGrey),
                                  borderRadius: BorderRadius.circular(
                                      context.width * 0.02),
                                ),
                                hintText: 'City',
                                hintStyle: TextStyle(
                                  fontFamily: HBMFonts.quicksandNormal,
                                  color: HBMColors.grey,
                                ),
                                textStyle: TextStyle(
                                    fontFamily: HBMFonts.quicksandNormal),
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
                                      context.width * 0.03),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HBMColors.charcoalGrey),
                                  borderRadius: BorderRadius.circular(
                                      context.width * 0.02),
                                ),
                                hintText: 'Street',
                                hintStyle: TextStyle(
                                  fontFamily: HBMFonts.quicksandNormal,
                                  color: HBMColors.grey,
                                ),
                                textStyle: TextStyle(
                                    fontFamily: HBMFonts.quicksandNormal),
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
                                      context.width * 0.03),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HBMColors.charcoalGrey),
                                  borderRadius: BorderRadius.circular(
                                      context.width * 0.02),
                                ),
                                hintText: 'State',
                                hintStyle: TextStyle(
                                  fontFamily: HBMFonts.quicksandNormal,
                                  color: HBMColors.grey,
                                ),
                                textStyle: TextStyle(
                                    fontFamily: HBMFonts.quicksandNormal),
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
                                      context.width * 0.03),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HBMColors.charcoalGrey),
                                  borderRadius: BorderRadius.circular(
                                      context.width * 0.02),
                                ),
                                hintText: 'Country',
                                hintStyle: TextStyle(
                                  fontFamily: HBMFonts.quicksandNormal,
                                  color: HBMColors.grey,
                                ),
                                textStyle: TextStyle(
                                    fontFamily: HBMFonts.quicksandNormal),
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
                                      context.width * 0.03),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HBMColors.charcoalGrey),
                                  borderRadius: BorderRadius.circular(
                                      context.width * 0.02),
                                ),
                                hintText: 'Zipcode',
                                hintStyle: TextStyle(
                                  fontFamily: HBMFonts.quicksandNormal,
                                  color: HBMColors.grey,
                                ),
                                textStyle: TextStyle(
                                    fontFamily: HBMFonts.quicksandNormal),
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
}
