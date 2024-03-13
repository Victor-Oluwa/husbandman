import 'package:husbandman/core/common/app/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    required super.video,
    required super.images,
    required super.inCart,
    required super.sold,
    required super.quantity,
    required super.price,
    required super.deliveryTime,
    required super.description,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['_id'] as String,
      name: map['name'] as String,
      video: map['video'] as String,
      images: (map['images'] as List).cast<String>(),
      inCart: map['inCart'] as int,
      sold: map['sold'] as int,
      quantity: map['quantity'] as int,
      price: map['price'] as double,
      deliveryTime: map['deliveryTime'] as String,
      description: map['description'] as String,
    );
  }

  const ProductModel.empty()
      : this(
          id: 'empty.id',
          name: 'empty.name',
          video: 'empty.video',
          images: const [],
          inCart: 0,
          sold: 0,
          quantity: 0,
          price: 0,
          deliveryTime: 'delivery-time.empty',
          description: 'description.empty',
        );

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'video': video,
      'images': images,
      'inCart': inCart,
      'sold': sold,
      'quantity': quantity,
      'price': price,
      'deliveryTime': deliveryTime,
      'description': description,
    };
  }
}
