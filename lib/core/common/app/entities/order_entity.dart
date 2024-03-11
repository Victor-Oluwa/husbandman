import 'package:equatable/equatable.dart';
import 'package:husbandman/core/common/app/entities/product_entity.dart';

class OrderEntity extends Equatable {
  const OrderEntity({
    required this.id,
    required this.farmer,
    required this.products,
    required this.time,
    required this.totalDeliveryTime,
  });

  const OrderEntity.empty()
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
}
