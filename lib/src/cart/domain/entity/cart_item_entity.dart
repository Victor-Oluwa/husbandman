import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  const CartItemEntity({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productQuantity,
    required this.sellerName,
    required this.sellerId,
    required this.deliveryDate,
    required this.percentage,
  });

  const CartItemEntity.empty()
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

  factory CartItemEntity.fromMap(Map<String, dynamic> map) {
    return CartItemEntity(
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

  final String id;
  final String productId;
  final String productName;
  final String productImage;
  final double productPrice;
  final int productQuantity;
  final String sellerName;
  final String sellerId;
  final String deliveryDate;
  final double percentage;

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
