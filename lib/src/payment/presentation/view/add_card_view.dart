import 'dart:developer';

import 'package:credit_card_validator/credit_card_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/user_provider.dart';
import 'package:husbandman/core/common/widgets/hbm_text_widget.dart';
import 'package:husbandman/core/extensions/context_extension.dart';
import 'package:husbandman/core/res/color.dart';
import 'package:husbandman/core/res/fonts.dart';
import 'package:husbandman/core/services/injection/payment/payment_injection.dart';
import 'package:husbandman/src/payment/presentation/bloc/payment_bloc.dart';

class AddCardView extends ConsumerStatefulWidget {
  const AddCardView({
    super.key,
  });

  @override
  ConsumerState<AddCardView> createState() => _AddCardViewState();
}

class _AddCardViewState extends ConsumerState<AddCardView> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';

  final formKey = GlobalKey<FormState>();
  final cardHolderKey = GlobalKey<FormFieldState<String>>();
  final cvvCodeKey = GlobalKey<FormFieldState<String>>();
  final cardNumberKey = GlobalKey<FormFieldState<String>>();
  final expiryDateKey = GlobalKey<FormFieldState<String>>();

  String? cardHolderValidator(String? cardHolderName) {
    if (cardHolderName == null || cardHolderName.isEmpty) {
      return 'Card holder name is required';
    }
    if (cardHolderName.length < 3) {
      return 'Card holder name is too short';
    }
    return null;
  }

  String? cvvValidator(String? cvv) {
    if (cvv == null || cvv.isEmpty) {
      return 'CVV is required';
    }
    if (cvv.length != 3 && cvv.length != 4) {
      return 'CVV must be 3 or 4 digits';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(cvv)) {
      return 'CVV must be numeric';
    }
    return null;
  }

  String? expiryDateValidator(String? expiryDate) {
    if (expiryDate == null || expiryDate.isEmpty) {
      return 'Field is required';
    }
    final parts = expiryDate.split('/');
    if (parts.length != 2) {
      return 'invalid format';
    }
    final month = int.tryParse(parts[0]);
    final year = int.tryParse(parts[1]);
    if (month == null || year == null) {
      return 'invalid format';
    }
    if (month < 1 || month > 12) {
      return 'Invalid Month';
    }
    final now = DateTime.now();
    final fourDigitYear = (year < 100) ? 2000 + year : year;
    final expiry = DateTime(fourDigitYear, month);
    if (expiry.isBefore(DateTime(now.year, now.month))) {
      return 'Card is expired';
    }
    return null;
  }

  String? cardNumberValidator(String? number) {
    if (number == null || number.isEmpty) {
      return 'Card number is required';
    }
    final validator = CreditCardValidator();
    final validation = validator.validateCCNum(number);
    if (!validation.isValid) {
      return 'Invalid card number';
    }
    return null;
  }

  String? cardBrand = 'Other Brand';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ref.watch(paymentBlocProvider),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: HBMColors.coolGrey,
        body: BlocConsumer<PaymentBloc, PaymentState>(
          listener: (context, state) {
            if (state is NewCardAdded) {
              log('New card added: ${state.card}');

              context.read<PaymentBloc>().add(
                    FetchCardsEvent(userId: ref.read(userProvider).id),
                  );
            }

            if(state is FetchedCards){
              context.read<PaymentBloc>().add(
                SetCardEvent(
                  cards: state.cards,
                  replaceList: true,
                ),
              );
            }

            if (state is CardSet) {
              log('Card set');
            }

            if (state is PaymentError) {
              log('Add new card error: ${state.message}');
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: context.height * 0.75,
                    width: context.width * 0.90,
                    child: Column(
                      children: [
                        CreditCardWidget(
                          cardBgColor: HBMColors.charcoalGrey,
                          cardNumber: cardNumber,
                          expiryDate: expiryDate,
                          cardHolderName: cardHolderName,
                          bankName: 'Bread',
                          cvvCode: cvvCode,
                          showBackView: false,
                          onCreditCardWidgetChange: (CreditCardBrand brand) {
                            cardBrand = brand.brandName?.name;
                          },
                          isHolderNameVisible: true,
                        ),
                        CreditCardForm(
                          formKey: formKey,
                          cardNumber: cardNumber,
                          expiryDate: expiryDate,
                          cardHolderName: cardHolderName,
                          cvvCode: cvvCode,
                          onCreditCardModelChange: (CreditCardModel data) {
                            setState(() {
                              cardNumber = data.cardNumber;
                              cardHolderName = data.cardHolderName;
                              expiryDate = data.expiryDate;
                              cvvCode = data.cvvCode;
                            });
                          },
                          obscureCvv: true,
                          obscureNumber: true,
                          cardNumberValidator: cardNumberValidator,
                          expiryDateValidator: expiryDateValidator,
                          cvvValidator: cvvValidator,
                          cardHolderValidator: cardHolderValidator,
                          onFormComplete: () {},
                          cardHolderKey: cardHolderKey,
                          cardNumberKey: cardNumberKey,
                          expiryDateKey: expiryDateKey,
                          cvvCodeKey: cvvCodeKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputConfiguration: InputConfiguration(
                            cardNumberDecoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(),
                              labelText: 'Number',
                              hintText: 'XXXX XXXX XXXX XXXX',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: HBMFonts.quicksandNormal,
                              ),
                            ),
                            expiryDateDecoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(),
                              labelText: 'Expired Date',
                              hintText: 'XX/XX',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: HBMFonts.quicksandNormal,
                              ),
                            ),
                            cvvCodeDecoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(),
                              labelText: 'CVV',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: HBMFonts.quicksandNormal,
                              ),
                              hintText: 'XXX',
                            ),
                            cardHolderDecoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(),
                              labelText: 'Card Holder',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: HBMFonts.quicksandNormal,
                              ),
                            ),
                            cardNumberTextStyle: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontFamily: HBMFonts.quicksandNormal,
                            ),
                            cardHolderTextStyle: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontFamily: HBMFonts.quicksandNormal,
                            ),
                            expiryDateTextStyle: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontFamily: HBMFonts.quicksandNormal,
                            ),
                            cvvCodeTextStyle: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontFamily: HBMFonts.quicksandNormal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: context.height * 0.02),
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<PaymentBloc>().add(
                                  AddNewCardEvent(
                                    holderName: cardHolderName,
                                    cardNumber: cardNumber,
                                    expiryDate: expiryDate,
                                    ccv: cvvCode,
                                    type: cardBrand ?? 'OtherBrand',
                                    ownerId: ref.read(userProvider).id,
                                  ),
                                );
                            return;
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HBMColors.charcoalGrey,
                          minimumSize: Size(
                            context.width * 0.85,
                            context.height * 0.06,
                          ),
                        ),
                        child: HBMTextWidget(
                          data: 'Save Card',
                          color: HBMColors.coolGrey,
                        ),
                      ),
                    ),
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
