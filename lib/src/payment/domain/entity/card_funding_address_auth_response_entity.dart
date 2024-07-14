import 'package:equatable/equatable.dart';

class CardFundingAddressAuthResponseEntity extends Equatable{
  const CardFundingAddressAuthResponseEntity({
    required this.message,
    this.transactionId,
    this.ref,
    this.status,
    this.url,
    this.info,
  });

  const CardFundingAddressAuthResponseEntity.empty():this(
    message: '',
    ref: '',
    transactionId: '',
    status: '',
    url: '',
    info: '',
  );

  final String message;
  final String? transactionId;
  final String? ref;
  final String? status;
  final String? url;
  final String? info;

  @override
  List<Object?> get props => [message, transactionId, ref, status, url, info];
}
