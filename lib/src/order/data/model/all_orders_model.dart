import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/order/data/model/order_items_model.dart';
import 'package:husbandman/src/order/domain/entity/all_orders_entity.dart';

class AllOrdersModel extends AllOrdersEntity {
  const AllOrdersModel({
    required super.id,
    required super.grossTotal,
    required super.orderName,
    required List<OrderItemsModel> super.orderItems,
  });

  factory AllOrdersModel.fromMap(Map<String, dynamic> map) {
    return AllOrdersModel(
      id: map['_id'] as String? ?? '',
      grossTotal: (map['grossTotal'] as num?)?.toDouble() ?? 0,
      orderName: map['orderName'] as String? ?? '',
      orderItems: (map['orderItems'] as List<dynamic>?)
              ?.map((item) =>
                  OrderItemsModel.fromMap(item as DataMap))
              .toList() ??
          [],
    );
  }

  static const empty = AllOrdersModel(
    id: '',
    grossTotal: 0,
    orderName: '',
    orderItems: [],
  );

  @override
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'grossTotal': grossTotal,
      'orderName': orderName,
      'orderItems': orderItems.map((item) => item.toMap()).toList(),
    };
  }

  @override
  List<Object?> get props => [id, grossTotal, orderName, orderItems];
}
