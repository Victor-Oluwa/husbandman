import 'package:husbandman/core/common/app/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    required super.video,
    required super.images,
    required super.sold,
    required super.quantity,
    required super.price,
    required super.deliveryTime,
    required super.description,
    required super.sellerName,
    required super.sellerEmail,
    required super.available,
    required super.measurement,
    required super.alwaysAvailable,
    required super.deliveryLocations,
    required super.rating,
    required super.likes,
    required super.type,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['_id'] as String ?? '',
      name: map['name'] as String ?? '',
      video: map['video'] as String ?? '',
      images: (map['images'] as List).cast<String>() ?? [],
      sold: map['sold'] as int ?? 0,
      quantity: map['quantity'] as int ?? 0,
      price: double.parse(map['price'].toString()) ?? 0.0,
      deliveryTime: map['deliveryTime'] as String ?? '',
      description: map['description'] as String ?? '',
      sellerName: map['sellerName'] as String ?? '',
      deliveryLocations:
          (map['deliveryLocations'] as List).cast<String>() ?? [],
      sellerEmail: map['sellerEmail'] as String ?? '',
      available: map['available'] as bool ?? true,
      measurement: map['measurement'] as String,
      alwaysAvailable: map['alwaysAvailable'] as bool ?? false,
      rating: (map['rating'] as List).cast<int>() ?? [],
      likes: map['likes'] as int ?? 0,
      type: map['type'] as String ?? '',
    );
  }

  ProductModel.empty()
      : this(
          id: 'empty.id',
          name: 'empty.name',
          video: 'empty.video',
          images: const [],
          sold: 0,
          quantity: 0,
          price: 0,
          deliveryTime: 'delivery-time.empty',
          description: 'description.empty',
          sellerName: 'empty.sellerName',
          sellerEmail: 'empty.sellerEmail',
          rating: [0],
          measurement: 'empty.measurement',
          likes: 0,
          deliveryLocations: [],
          available: true,
          alwaysAvailable: false,
          type: 'empty.type',
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'sellerName': sellerName,
      'sellerEmail': sellerEmail,
      'video': video,
      'images': images,
      'available': available,
      'sold': sold,
      'quantity': quantity,
      'price': price,
      'deliveryTime': deliveryTime,
      'description': description,
      'measurement': measurement,
      'alwaysAvailable': alwaysAvailable,
      'deliveryLocations': deliveryLocations,
      'rating': rating,
      'likes': likes,
      'type': type,
    };
  }
}
