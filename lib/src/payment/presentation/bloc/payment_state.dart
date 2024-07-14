part of 'payment_bloc.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

final class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentError extends PaymentState {
  const PaymentError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}

class NewCardAdded extends PaymentState {
  const NewCardAdded(this.card);

  final PaymentCardEntity card;

  @override
  List<PaymentCardEntity> get props => [card];
}

class CardDeleted extends PaymentState {
  const CardDeleted();
}

class FetchedCards extends PaymentState {
  const FetchedCards(this.cards);

  final List<PaymentCardEntity> cards;

  @override
  List<List<PaymentCardEntity>> get props => [cards];
}

class CardSet extends PaymentState {
  const CardSet();
}

class InitializedCardFunding extends PaymentState {
  const InitializedCardFunding(this.response);

  final InitializeCardFundingResponseEntity response;

  @override
  List<InitializeCardFundingResponseEntity> get props => [response];
}

class AuthorizedCardFundingWithPin extends PaymentState{
 const AuthorizedCardFundingWithPin(this.response);

  final CardFundingPinAuthResponseEntity response;
  @override
  List<CardFundingPinAuthResponseEntity> get props => [response];
}

class AuthorizedCardFundingWithAddress extends PaymentState{
  const AuthorizedCardFundingWithAddress(this.response);

  final CardFundingAddressAuthResponseEntity response;
  @override
  List<CardFundingAddressAuthResponseEntity> get props => [response];
}

class ValidatedCardFundingWithOtp extends PaymentState{
  const ValidatedCardFundingWithOtp(this.transactionId);

  final String transactionId;
  @override
  List<String> get props => [transactionId];
}

class VerifiedCardFunding extends PaymentState{
 const VerifiedCardFunding(this.status);

  final String status;
  @override
  List<String> get props =>[status];
}


