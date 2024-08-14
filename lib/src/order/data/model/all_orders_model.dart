import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/order/data/model/order_items_model.dart';
import 'package:husbandman/src/order/domain/entity/all_orders_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'all_orders_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AllOrdersModel extends AllOrdersEntity {
  const AllOrdersModel({
     required super.grossTotal, required super.orderName, required List<OrderItemsModel> super.orderItems, required super.totalPercentage, super.id,
  });

  factory AllOrdersModel.fromJson(DataMap json)=> _$AllOrdersModelFromJson(json);
  @override
  DataMap toJson()=> _$AllOrdersModelToJson(this);

  static const empty = AllOrdersModel(
    grossTotal: 0,
    orderName: '',
    totalPercentage: 0,
    orderItems: [],
  );

  @override
  List<Object?> get props => [
        id,
        grossTotal,
        orderName,
        orderItems,
        totalPercentage,
      ];
}
