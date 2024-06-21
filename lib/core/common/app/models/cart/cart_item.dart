class CartItem {
  CartItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productQuantity,
    required this.sellerName,
    required this.sellerId,
    required this.deliveryDate,
  });

  CartItem.empty():this(
    id: '',
    deliveryDate: '',
    productId: '',
    productName: '',
    productPrice: 0,
    productQuantity: 0,
    sellerId: '',
    sellerName: '',
      productImage:''
  );

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['_id'] as String? ?? '',
      productId: map['productId'] as String? ?? '',
      productName: map['productName'] as String? ?? '',
      productImage: map['productImage'] as String? ?? '',
      productPrice: double.parse(map['price'].toString()) ?? 0,
      productQuantity: map['quantity'] as int? ?? 0,
      sellerName: map['sellerName'] as String? ?? '',
      sellerId: map['sellerId'] as String? ?? '',
      deliveryDate: map['deliveryDate'] as String? ?? '',
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
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
