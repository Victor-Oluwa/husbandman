import 'package:equatable/equatable.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/cart/domain/entity/cart_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class CartEntity extends Equatable {
  const CartEntity({
    required this.ownerId,
    required this.items,
    required this.id,
  });

  CartEntity.empty():this(
    ownerId: 'empty.ownerId',
    id: 'empty.id',
    items: [],
  );

  factory CartEntity.fromJson(DataMap json) => _$CartEntityFromJson(json);
  DataMap toJson() => _$CartEntityToJson(this);

  @JsonKey(name: '_id')
  final String id;
  final String ownerId;
  final List<CartItemEntity> items;

  @override
  List<Object?> get props => [id, ownerId, items];

}
