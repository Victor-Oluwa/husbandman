import 'package:husbandman/src/cart/data/model/cart_item.dart';
import 'package:husbandman/src/cart/domain/entity/cart_entity.dart';

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

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['_id'] as String? ?? '',
      ownerId: map['ownerId'] as String? ?? '',
      items: (map['items'] as List<dynamic>)
          .map((item) => CartItem.fromMap(item as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'ownerId': ownerId,
      'items': items.map((item) => item.toMap()).toList(),
    };
  }

  @override
  List<Object?> get props => [id, ownerId, items];

}
