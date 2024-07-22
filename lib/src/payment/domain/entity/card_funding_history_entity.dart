import 'package:equatable/equatable.dart';
import 'package:husbandman/core/enums/failure_stage.dart';
import 'package:husbandman/core/enums/funding_status.dart';

class CardFundingHistoryEntity extends Equatable {
  const CardFundingHistoryEntity({
    required this.id,
    required this.userId,
    required this.transactionId,
    required this.cardHolderName,
    required this.userEmail,
    required this.cardNumber,
    required this.fundingStatus,
    required this.date,
    required this.time,
    this.failureStage,
    this.failureMessage,
    this.userLocation,
    this.isBrowserAuth =false,
  });

  factory CardFundingHistoryEntity.fromMap(Map<String, dynamic> map) {
    return CardFundingHistoryEntity(
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

  final String id;
  final String userId;
  final String transactionId;
  final String cardHolderName;
  final String userEmail;
  final String cardNumber;
  final FundingStatus fundingStatus;
  final FailureStage? failureStage;
  final String? failureMessage;
  final String date;
  final String time;
  final String? userLocation;
  final bool isBrowserAuth;

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
    isBrowserAuth,
      ];

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
}
