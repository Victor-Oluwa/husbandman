import 'package:equatable/equatable.dart';
import 'package:husbandman/core/utils/typedef.dart';

class InitializeCardFundingResponseEntity extends Equatable{
  const InitializeCardFundingResponseEntity({
    required this.message,
     this.payload,
     this.url,
    this.transactionId,
  });

  const InitializeCardFundingResponseEntity.empty():this(
    message: '',
    url: '',
    transactionId: 'none',
    payload: const{},
  );

  final String message;
  final DataMap? payload;
  final String? url;
  final String? transactionId;

  @override
  List<dynamic> get props => [message, payload, url, transactionId];
}
