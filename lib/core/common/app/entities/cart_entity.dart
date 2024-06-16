import 'package:equatable/equatable.dart';
import 'package:husbandman/core/common/app/models/cart/cart_item.dart';
import 'package:husbandman/core/common/app/models/product_model.dart';

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

  factory CartEntity.fromMap(Map<String, dynamic> map) {
    return CartEntity(
      id: map['_id'] as String ?? '',
      ownerId: map['ownerId'] as String ?? '',
      items: (map['items'] as List).cast<CartItem>() ?? [],
    );
  }

  final String id;
  final String ownerId;
  final List<CartItem> items;

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
