import 'package:husbandman/core/common/app/entities/payment_card_entity.dart';
import 'package:husbandman/core/common/app/models/payment_card_model.dart';
import 'package:husbandman/core/enums/update_card_funding_history.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/payment/data/model/card_funding_address_auth_response.dart';
import 'package:husbandman/src/payment/data/model/card_funding_pin_auth_response.dart';
import 'package:husbandman/src/payment/data/model/initialize_card_funding_response_model.dart';
import 'package:husbandman/src/payment/domain/entity/card_funding_address_auth_response_entity.dart';
import 'package:husbandman/src/payment/domain/entity/card_funding_history_entity.dart';

abstract class PaymentDatasource {
  Future<PaymentCardModel> addNewCard({
    required String holderName,
    required String cardNumber,
    required String expiryDate,
    required String ccv,
    required String type,
    required String ownerId,
  });

  Future<void> deleteCard(String cardId);

  Future<List<PaymentCardModel>> fetchCards(String userId);

  Future<void> setCard({
    required List<PaymentCardEntity> cards,
    required bool replaceList,
  });

  Future<InitializeCardFundingResponse> initializeCardFunding({
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

  Future<CardFundingPinAuthResponse> cardFundingPinAuth({
    required String pin,
    required DataMap payload,
  });

  Future<CardFundingAddressAuthResponse> cardFundingAddressAuth({
    required DataMap payload,
    required String address,
    required String city,
    required String state,
    required String country,
    required String zipCode
  });

  Future<String> cardFundingOtpValidation({
    required String otp,
    required String ref,
  });

  Future<String> cardFundingVerification({
    required String transactionId,
  });

  Future<String> addNewCardFundingHistory({
    required CardFundingHistoryEntity history,
  });

  Future<String> updateCardFundingHistory({
    required String historyId,
    required List<dynamic> values,
    required List<UpdateCardFundingHistoryCulprit> culprits,
  });

  Future<List<CardFundingHistoryEntity>> fetchCardFundingHistory();

}
