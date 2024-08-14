
import 'package:equatable/equatable.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/order/domain/entity/order_items_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'all_orders_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class AllOrdersEntity extends Equatable {
  const AllOrdersEntity({
    required this.grossTotal,
    required this.totalPercentage,
    required this.orderName,
    required this.orderItems,
    this.id = '',
  });

factory AllOrdersEntity.fromJson(DataMap json)=> _$AllOrdersEntityFromJson(json);
DataMap toJson()=> _$AllOrdersEntityToJson(this);

  static const empty = AllOrdersEntity(
    grossTotal: 0,
    orderName: '',
    totalPercentage: 0,
    orderItems: [],
  );

  @JsonKey(name: '_id')
  final String id;
  final double grossTotal;
  final String orderName;
  final double totalPercentage;
  final List<OrderItemsEntity> orderItems;

  @override
  List<Object?> get props => [id, grossTotal, orderName, orderItems];
}
