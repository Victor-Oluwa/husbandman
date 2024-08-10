
import 'package:equatable/equatable.dart';
import 'package:husbandman/src/order/domain/entity/order_items_entity.dart';

class AllOrdersEntity extends Equatable {
  const AllOrdersEntity({
    required this.grossTotal,
    required this.totalPercentage,
    required this.orderName,
    required this.orderItems,
    this.id = '',
  });

  factory AllOrdersEntity.fromMap(Map<String, dynamic> map) {
    return AllOrdersEntity(
      id: map['_id'] as String? ?? '',
      grossTotal: (map['grossTotal'] as num?)?.toDouble() ?? 0.0,
      orderName: map['orderName'] as String? ?? '',
      totalPercentage: (map['totalPercentage']as num?)?.toDouble()?? 0.0,
      orderItems: (map['orderItems'] as List<dynamic>?)
          ?.map((item) => OrderItemsEntity.fromMap(item as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  static const empty = AllOrdersEntity(
    id: '',
    grossTotal: 0,
    orderName: '',
    totalPercentage: 0,
    orderItems: [],
  );

  final String id;
  final double grossTotal;
  final String orderName;
  final double totalPercentage;
  final List<OrderItemsEntity> orderItems;

  Map<String, dynamic> toMap() {
    return {
      'grossTotal': grossTotal,
      'orderName': orderName,
      'totalPercentage':totalPercentage,
      'orderItems': orderItems.map((item) => item.toMap()).toList(),
    };
  }

  @override
  List<Object?> get props => [id, grossTotal, orderName, orderItems];
}
