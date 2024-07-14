import 'package:husbandman/src/payment/domain/entity/card_funding_history_entity.dart';

class CardFundingHistory extends CardFundingHistoryEntity {
  const CardFundingHistory({
    required super.id,
    required super.userId,
    required super.cardHolderName,
    required super.userEmail,
    required super.cardNumber,
    required super.fundingStatus,
    required super.date,
    required super.time,
    super.failureMessage,
    super.failureStage,
    super.userLocation,
  });

  @override
  List<dynamic> get props => [
    id,
    userId,
    cardHolderName,
    userEmail,
    cardNumber,
    date,
    time,
    fundingStatus,
  ];
}
