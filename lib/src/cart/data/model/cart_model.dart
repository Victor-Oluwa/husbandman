import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/cart/data/model/cart_item.dart';
import 'package:husbandman/src/cart/domain/entity/cart_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CartModel extends CartEntity {
  const CartModel({
    required super.ownerId,
    required List<CartItem> super.items,
    required super.id,
  });

  CartModel.empty():this(
    ownerId: '',
    id: '',
    items: [],
  );

  factory CartModel.fromJson(DataMap json) => _$CartModelFromJson(json);
  @override
  DataMap toJson() => _$CartModelToJson(this);

  @override
  List<Object?> get props => [id, ownerId, items];

}
