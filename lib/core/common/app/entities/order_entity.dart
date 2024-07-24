import 'package:equatable/equatable.dart';
import 'package:husbandman/core/common/app/entities/product_entity.dart';

class OrderEntityOld extends Equatable {
  const OrderEntityOld({
    required this.id,
    required this.farmer,
    required this.products,
    required this.time,
    required this.totalDeliveryTime,
  });

  factory OrderEntityOld.fromMap(Map<String, dynamic> map) {
    return OrderEntityOld(
      id: map['_id'] as String,
      farmer: map['farmer'] as String,
      products: map['products'] as List<ProductEntity>,
      time: map['time'] as String,
      totalDeliveryTime: map['totalDeliveryTime'] as String,
    );
  }

  const OrderEntityOld.empty()
      : this(
          id: 'empty.id',
          farmer: 'empty.farmer',
          products: const [],
          time: 'empty.time',
          totalDeliveryTime: 'empty.totalDeliveryTime',
        );

  final String id;
  final String farmer;
  final List<ProductEntity> products;
  final String time;
  final String totalDeliveryTime;

  @override
  List<Object?> get props => [farmer, products, time, totalDeliveryTime];

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'farmer': farmer,
      'products': products,
      'time': time,
      'totalDeliveryTime': totalDeliveryTime,
    };
  }
}
