import 'package:husbandman/core/common/app/entities/payment_card_entity.dart';
import 'package:husbandman/core/enums/update_card_funding_history.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/payment/domain/entity/card_funding_address_auth_response_entity.dart';
import 'package:husbandman/src/payment/domain/entity/card_funding_history_entity.dart';
import 'package:husbandman/src/payment/domain/entity/card_funding_pin_auth_response_entity.dart';
import 'package:husbandman/src/payment/domain/entity/initialize_card_funding_response_entity.dart';

abstract class PaymentRepo {
  ResultFuture<PaymentCardEntity> addNewCard({
    required String holderName,
    required String cardNumber,
    required String expiryDate,
    required String ccv,
    required String type,
    required String ownerId,
  });

  ResultFuture<void> deleteCard(
    String cardId,
  );

  ResultFuture<List<PaymentCardEntity>> fetchCards(String userId);

  ResultFuture<void> setCard({
    required List<PaymentCardEntity> cards,
    required bool replaceList,
  });

  ResultFuture<InitializeCardFundingResponseEntity> initializeCardFunding({
    required String cardNumber,
    required String cvv,
    required String expiryYear,
    required String expiryMonth,
    required String currency,
    required String amount,
    required String redirectUrl,
    required String fullName,
    required String email,
    required String phone,
    required String ref,
  });

  ResultFuture<CardFundingPinAuthResponseEntity> cardFundingPinAuth({
    required String pin,
    required DataMap payload,
  });

  ResultFuture<CardFundingAddressAuthResponseEntity> cardFundingAddressAuth(
      {required DataMap payload,
      required String address,
      required String city,
      required String state,
      required String country,
      required String zipCode,});

  ResultFuture<String> cardFundingOtpValidation({
    required String otp,
    required String ref,
  });

  ResultFuture<String> cardFundingVerification({
    required String transactionId,
  });

  ResultFuture<String> addNewCardFundingHistory({
    required CardFundingHistoryEntity history,
  });

  ResultFuture<String> updateCardFundingHistory({
    required String historyId,
    required List<dynamic> values,
    required List<UpdateCardFundingHistoryCulprit> culprits,
  });

  ResultFuture<List<CardFundingHistoryEntity>> fetchCardFundingHistory();
}
