import 'package:cloudinary/cloudinary.dart';
import 'package:dartz/dartz.dart';
import 'package:husbandman/core/common/app/entities/payment_card_entity.dart';
import 'package:husbandman/core/common/app/models/payment_card_model.dart';
import 'package:husbandman/core/enums/update_card_funding_history.dart';
import 'package:husbandman/core/error/exceptions.dart';
import 'package:husbandman/core/error/failure.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/payment/data/datasource/payment_datasource.dart';
import 'package:husbandman/src/payment/data/model/card_funding_pin_auth_response.dart';
import 'package:husbandman/src/payment/data/model/initialize_card_funding_response_model.dart';
import 'package:husbandman/src/payment/domain/entity/card_funding_address_auth_response_entity.dart';
import 'package:husbandman/src/payment/domain/entity/card_funding_history_entity.dart';
import 'package:husbandman/src/payment/domain/repo/payment_repo.dart';

class PaymentRepoImpl implements PaymentRepo {
  PaymentRepoImpl({required PaymentDatasource paymentDatasource})
      : _paymentDatasource = paymentDatasource;

  final PaymentDatasource _paymentDatasource;

  @override
  ResultFuture<PaymentCardModel> addNewCard({
    required String holderName,
    required String cardNumber,
    required String expiryDate,
    required String ccv,
    required String type,
    required String ownerId,
  }) async {
    try {
      final result = await _paymentDatasource.addNewCard(
        holderName: holderName,
        cardNumber: cardNumber,
        expiryDate: expiryDate,
        ccv: ccv,
        type: type,
        ownerId: ownerId,
      );
      return Right(result);
    } on PaymentException catch (e) {
      return Left(PaymentFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> deleteCard(String cardId) async {
    try {
      final result = await _paymentDatasource.deleteCard(cardId);
      return Right(result);
    } on PaymentException catch (e) {
      return Left(PaymentFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<PaymentCardModel>> fetchCards(String userId) async {
    try {
      final result = await _paymentDatasource.fetchCards(userId);
      return Right(result);
    } on PaymentException catch (e) {
      return Left(PaymentFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> setCard({
    required List<PaymentCardEntity> cards,
    required bool replaceList,
  }) async {
    try {
      final result = await _paymentDatasource.setCard(
        replaceList: replaceList,
        cards: cards,
      );
      return Right(result);
    } on PaymentException catch (e) {
      return Left(PaymentFailure.fromException(e));
    }
  }

  @override
  ResultFuture<InitializeCardFundingResponse> initializeCardFunding({
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
  }) async {
    try {
      final result = await _paymentDatasource.initializeCardFunding(
        cardNumber: cardNumber,
        cvv: cvv,
        expiryYear: expiryYear,
        expiryMonth: expiryMonth,
        currency: currency,
        amount: amount,
        redirectUrl: redirectUrl,
        fullName: fullName,
        email: email,
        phone: phone,
        ref: ref,
      );

      return Right(result);
    } on PaymentException catch (e) {
      return Left(PaymentFailure.fromException(e));
    }
  }

  @override
  ResultFuture<CardFundingPinAuthResponse> cardFundingPinAuth({
    required String pin,
    required DataMap payload,
  }) async {
    try {
      final result = await _paymentDatasource.cardFundingPinAuth(
        pin: pin,
        payload: payload,
      );

      return Right(result);
    } on PaymentException catch (e) {
      return Left(PaymentFailure.fromException(e));
    }
  }

  @override
  ResultFuture<CardFundingAddressAuthResponseEntity> cardFundingAddressAuth({
    required DataMap payload,
    required String address,
    required String city,
    required String state,
    required String country,
    required String zipCode,
  }) async {
    try {
      final result = await _paymentDatasource.cardFundingAddressAuth(
        payload: payload,
        address: address,
        city: city,
        state: state,
        country: country,
        zipCode: zipCode,
      );
      return Right(result);
    } on PaymentException catch (e) {
      return Left(PaymentFailure.fromException(e));
    }
  }

  @override
  ResultFuture<String> cardFundingOtpValidation({
    required String otp,
    required String ref,
  }) async {
    try {
      final result = await _paymentDatasource.cardFundingOtpValidation(
        otp: otp,
        ref: ref,
      );

      return Right(result);
    } on PaymentException catch (e) {
      return Left(PaymentFailure.fromException(e));
    }
  }

  @override
  ResultFuture<String> cardFundingVerification({
    required String transactionId,
  }) async {
    try {
      final result = await _paymentDatasource.cardFundingVerification(
        transactionId: transactionId,
      );
      return Right(result);
    } on PaymentException catch (e) {
      return Left(PaymentFailure.fromException(e));
    }
  }

  @override
  ResultFuture<String> addNewCardFundingHistory({
    required CardFundingHistoryEntity history,
  }) async {
    try {
      final result =
          await _paymentDatasource.addNewCardFundingHistory(history: history);
      return Right(result);
    } on PaymentException catch (e) {
      return Left(PaymentFailure.fromException(e));
    }
  }

  @override
  ResultFuture<String> updateCardFundingHistory({
    required String historyId,
    required List<dynamic> values,
    required List<UpdateCardFundingHistoryCulprit> culprits,
  }) async {
    try {
      final result = await _paymentDatasource.updateCardFundingHistory(
        historyId: historyId,
        values: values,
        culprits: culprits,
      );
      return Right(result);
    } on PaymentException catch (e) {
      return Left(PaymentFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<CardFundingHistoryEntity>> fetchCardFundingHistory() async {
    try {
      final result = await _paymentDatasource.fetchCardFundingHistory();
      return Right(result);
    } on PaymentException catch (e) {
      return Left(PaymentFailure.fromException(e));
    }
  }
}
