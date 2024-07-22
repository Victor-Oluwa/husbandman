import 'package:husbandman/core/enums/failure_stage.dart';
import 'package:husbandman/core/enums/funding_status.dart';
import 'package:husbandman/src/payment/domain/entity/card_funding_history_entity.dart';

class CardFundingHistory extends CardFundingHistoryEntity {
  const CardFundingHistory({
    required super.id,
    required super.userId,
    required super.cardHolderName,
    required super.userEmail,
    required super.cardNumber,
    required super.fundingStatus,
    required super.transactionId,
    required super.date,
    required super.time,
    super.failureMessage,
    super.failureStage,
    super.userLocation,
    super.isBrowserAuth,
  });

  @override
  factory CardFundingHistory.fromMap(Map<String, dynamic> map) {
    return CardFundingHistory(
      id: map['_id'] as String,
      userId: map['userId'] as String,
      transactionId: map['transactionId'] as String,
      cardHolderName: map['cardHolderName'] as String,
      userEmail: map['userEmail'] as String,
      cardNumber: map['cardNumber'] as String,
      fundingStatus:
      map['fundingStatus'] as FundingStatus,
      failureStage: map['failureStage'] as FailureStage? ?? FailureStage.none,
      failureMessage: map['failureMessage'] as String? ?? '',
      date: map['date'] as String,
      time: map['time'] as String,
      userLocation: map['userLocation'] as String? ?? '',
      isBrowserAuth: map['isBrowserAuth'] as bool? ?? false,
    );
  }
@override
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'userId': userId,
      'transactionId': transactionId,
      'cardHolderName': cardHolderName,
      'userEmail': userEmail,
      'cardNumber': cardNumber,
      'fundingStatus': fundingStatus,
      'failureStage': failureStage,
      'failureMessage': failureMessage,
      'date': date,
      'time': time,
      'userLocation': userLocation,
      'isBrowserAuth': isBrowserAuth,
    };
  }

  @override
  List<dynamic> get props => [
    id,
    userId,
    transactionId,
    cardHolderName,
    userEmail,
    cardNumber,
    date,
    time,
    fundingStatus,
    isBrowserAuth,
  ];
}
