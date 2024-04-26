import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  const ProductEntity({
    required this.id,
    required this.name,
    required this.sellerName,
    required this.sellerEmail,
    required this.images,
    required this.available,
    required this.sold,
    required this.quantity,
    required this.price,
    required this.deliveryTime,
    required this.description,
    required this.measurement,
    required this.alwaysAvailable,
    required this.deliveryLocations,
    required this.rating,
    required this.likes,
    required this.type,
    this.video,
  });

  factory ProductEntity.fromMap(Map<String, dynamic> map) {
    return ProductEntity(
      id: map['_id'] as String ?? '',
      name: map['name'] as String ?? '',
      video: map['video'] as String ?? '',
      images: (map['images'] as List).cast<String>(),
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

  ProductEntity.empty()
      : this(
          id: 'empty.id',
          name: 'empty.name',
          video: 'empty.video',
          images: const ['empty.images'],
          sold: 10,
          quantity: 59,
          price: 20000000,
          deliveryTime: 'deliveryTime.empty',
          description: '',
          alwaysAvailable: false,
          available: true,
          deliveryLocations: ['location.empty'],
          likes: 5,
          measurement: '',
          rating: [9],
          sellerEmail: 'sellerEmail.empty',
          sellerName: 'sellerName.empty',
          type: 'empty.type',
        );
  final String id;
  final String name;
  final String sellerName;
  final String sellerEmail;
  final String? video;
  final List<String> images;
  final bool available;
  final int sold;
  final int quantity;
  final double price;
  final String deliveryTime;
  final String description;
  final String measurement;
  final bool alwaysAvailable;
  final List<String> deliveryLocations;
  final List<int> rating;
  final int likes;
  final String type;

  @override
  List<Object> get props => [id, name, images, price, description];

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
