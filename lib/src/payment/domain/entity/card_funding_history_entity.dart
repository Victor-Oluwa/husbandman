import 'package:equatable/equatable.dart';
import 'package:husbandman/core/enums/failure_stage.dart';
import 'package:husbandman/core/enums/funding_status.dart';

class CardFundingHistoryEntity extends Equatable {
 const CardFundingHistoryEntity({
    required this.id,
    required this.userId,
    required this.cardHolderName,
    required this.userEmail,
    required this.cardNumber,
    required this.fundingStatus,
    required this.date,
    required this.time,
    this.failureStage,
    this.failureMessage,
    this.userLocation,
  });

  final String id;
  final String userId;
  final String cardHolderName;
  final String userEmail;
  final bool cardNumber;
  final FundingStatus fundingStatus;
  final FailureStage? failureStage;
  final String? failureMessage;
  final String date;
  final String time;
  final String? userLocation;

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
