import 'package:husbandman/src/cart/domain/entity/cart_item_entity.dart';

class CartItem extends CartItemEntity {
 const CartItem({
    required super.id,
    required super.productId,
    required super.productName,
    required super.productImage,
    required super.productPrice,
    required super.productQuantity,
    required super.sellerName,
    required super.sellerId,
    required super.deliveryDate,
    required super.percentage,
  });

 const CartItem.empty()
      : this(
          id: '',
          deliveryDate: '',
          productId: '',
          productName: '',
          productPrice: 0,
          productQuantity: 0,
          sellerId: '',
          sellerName: '',
          productImage: '',
          percentage: 0,
        );

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['_id'] as String? ?? '',
      productId: map['productId'] as String? ?? '',
      productName: map['productName'] as String? ?? '',
      productImage: map['productImage'] as String? ?? '',
      productPrice: double.parse(map['price'].toString()) ?? 0.0,
      productQuantity: map['quantity'] as int? ?? 0,
      sellerName: map['sellerName'] as String? ?? '',
      sellerId: map['sellerId'] as String? ?? '',
      deliveryDate: map['deliveryDate'] as String? ?? '',
      percentage: double.parse(map['percentage'].toString()) ?? 0.0,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'price': productPrice,
      'quantity': productQuantity,
      'sellerName': sellerName,
      'sellerId': sellerId,
      'deliveryDate': deliveryDate,
      'percentage': percentage,
    };
  }

  @override
  List<dynamic> get props => [
        id,
        productId,
        productName,
        productImage,
        productPrice,
        productQuantity,
        sellerName,
        sellerId,
        deliveryDate,
        percentage,
      ];
}
