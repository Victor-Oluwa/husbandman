part of 'payment_bloc.dart';

sealed class PaymentEvent extends Equatable {
  const PaymentEvent();
}

class AddNewCardEvent extends PaymentEvent {
  const AddNewCardEvent({
    required this.holderName,
    required this.cardNumber,
    required this.expiryDate,
    required this.ccv,
    required this.type,
    required this.ownerId,
  });

  final String holderName;
  final String cardNumber;
  final String expiryDate;
  final String ccv;
  final String type;
  final String ownerId;

  @override
  List<String> get props => [
        holderName,
        cardNumber,
        expiryDate,
        ccv,
        type,
      ];
}

class DeleteCardEvent extends PaymentEvent {
  const DeleteCardEvent({required this.cartId});

  final String cartId;

  @override
  List<String> get props => [cartId];
}

class FetchCardsEvent extends PaymentEvent {
  const FetchCardsEvent({required this.userId});

  final String userId;

  @override
  List<String> get props => [userId];
}

class SetCardEvent extends PaymentEvent {
  const SetCardEvent({
    required this.cards,
    required this.replaceList,
  });

  final List<PaymentCardEntity> cards;
  final bool replaceList;

  @override
  List<Object?> get props => [cards, replaceList];
}

class CardFundingPinAuthEvent extends PaymentEvent {
  const CardFundingPinAuthEvent({
    required this.pin,
    required this.payload,
  });

  final String pin;
  final DataMap payload;

  @override
  List<dynamic> get props => [pin, payload];
}

class CardFundingAddressAuthEvent extends PaymentEvent {
  const CardFundingAddressAuthEvent({
    required this.payload,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
  });

  final DataMap payload;
  final String address;
  final String city;
  final String state;
  final String country;
  final String zipCode;

  @override
  List<dynamic> get props => [
        payload,
        address,
        city,
        state,
        country,
        zipCode,
      ];
}

class CardFundingOtpValidationEvent extends PaymentEvent {
  const CardFundingOtpValidationEvent({
    required this.otp,
    required this.ref,
  });

  final String otp;
  final String ref;

  @override
  List<String> get props => [otp, ref];
}

class InitializeCardFundingEvent extends PaymentEvent {
  const InitializeCardFundingEvent(
      {required this.cardNumber,
      required this.cvv,
      required this.expiryYear,
      required this.expiryMonth,
      required this.currency,
      required this.amount,
      required this.redirectUrl,
      required this.fullName,
      required this.email,
      required this.phone,
      required this.ref});

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
        ref,
        phone,
        email,
        fullName,
        redirectUrl,
        amount,
        currency,
        expiryMonth,
        expiryYear,
        cvv,
        cardNumber,
      ];
}

class CardFundingVerificationEvent extends PaymentEvent {
  const CardFundingVerificationEvent({
    required this.transactionId,
  });

  final String transactionId;

  @override
  List<String> get props => [transactionId];
}

class AddNewCardFundingHistoryEvent extends PaymentEvent {
  const AddNewCardFundingHistoryEvent({required this.history});

  final CardFundingHistoryEntity history;

  @override
  List<CardFundingHistoryEntity> get props => [history];
}

class UpdateCardFundingHistoryEvent extends PaymentEvent {
 const UpdateCardFundingHistoryEvent({
    required this.historyId,
    required this.values,
    required this.culprits,
  });

  final String historyId;
  final List<dynamic> values;
  final List<UpdateCardFundingHistoryCulprit> culprits;

  @override
  List<dynamic> get props => [historyId, values, culprits];
}

class FetchCardFundingHistoryEvent extends PaymentEvent{
  @override
  List<dynamic> get props => [];
}
