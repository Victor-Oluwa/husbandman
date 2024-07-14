import 'package:equatable/equatable.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/payment/domain/entity/initialize_card_funding_response_entity.dart';
import 'package:husbandman/src/payment/domain/repo/payment_repo.dart';

class InitializeCardFunding extends UseCaseWithParams<
    InitializeCardFundingResponseEntity, InitializeCardFundingParams> {
  InitializeCardFunding({required PaymentRepo paymentRepo})
      : _paymentRepo = paymentRepo;

  final PaymentRepo _paymentRepo;

  @override
  ResultFuture<InitializeCardFundingResponseEntity> call(
    InitializeCardFundingParams params,
  ) {
    return _paymentRepo.initializeCardFunding(
      cardNumber: params.cardNumber,
      cvv: params.cvv,
      expiryYear: params.expiryYear,
      expiryMonth: params.expiryMonth,
      currency: params.currency,
      amount: params.amount,
      redirectUrl: params.redirectUrl,
      fullName: params.fullName,
      email: params.email,
      phone: params.phone,
      ref: params.ref,
    );
  }
}

class InitializeCardFundingParams extends Equatable {
  const InitializeCardFundingParams({
    required this.cardNumber,
    required this.cvv,
    required this.expiryYear,
    required this.expiryMonth,
    required this.currency,
    required this.amount,
    required this.redirectUrl,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.ref,
  });

  final String cardNumber;
  final String cvv;
  final String expiryYear;
  final String expiryMonth;
  final String currency;
  final String amount;
  final String redirectUrl;
  final String fullName;
  final String email;
  final String phone;
  final String ref;

  @override
  List<String> get props => [
        cardNumber,
        cvv,
        expiryYear,
        expiryMonth,
        currency,
        amount,
        redirectUrl,
        fullName,
        email,
        phone,
        ref,
      ];
}
