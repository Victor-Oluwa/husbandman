import 'package:husbandman/core/common/app/entities/order_entity.dart';
import 'package:husbandman/core/common/app/entities/product_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.farmer,
    required super.products,
    required super.time,
    required super.totalDeliveryTime,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['_id'] as String,
      farmer: map['farmer'] as String,
      products: (map['products'] as List).cast<ProductEntity>(),
      time: map['time'] as String,
      totalDeliveryTime: map['totalDeliveryTime'] as String,
    );
  }

 const OrderModel.empty()
      : this(
          id: 'empty.id',
          farmer: 'empty.farmer',
          products: const [],
          time: 'empty.time',
          totalDeliveryTime: 'empty.totalDeliveryTime',
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'farmer': farmer,
      'products': products,
      'time': time,
      'totalDeliveryTime': totalDeliveryTime,
    };
  }

  @override
  List<Object> get props => [farmer, products, time, totalDeliveryTime];
}
