import 'package:husbandman/core/common/app/entities/cart_entity.dart';

import 'package:husbandman/core/common/app/models/cart/cart_item.dart';

class CartModel extends CartEntity {
  const CartModel({
    required super.ownerId,
    required super.items,
    required super.id,
  });

  CartModel.empty():this(
    ownerId: '',
    id: '',
    items: [],
  );

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['_id'] as String ?? '',
      ownerId: map['ownerId'] as String ?? '',
      items: (map['items'] as List).cast<CartItem>() ?? [],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'ownerId': ownerId,
      'items': items,
    };
  }

  @override
  List<Object?> get props => [id, ownerId, items];

}
