import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  const ProductEntity({
    required this.id,
    required this.name,
    required this.video,
    required this.images,
    required this.inCart,
    required this.sold,
    required this.quantity,
    required this.price,
    required this.deliveryTime,
    required this.description,
  });

  factory ProductEntity.fromMap(Map<String, dynamic> map) {
    return ProductEntity(
      id: map['_id'] as String,
      name: map['name'] as String,
      video: map['video'] as String,
      images: map['images'] as List<String>,
      inCart: map['inCart'] as int,
      sold: map['sold'] as int,
      quantity: map['quantity'] as int,
      price: map['price'] as double,
      deliveryTime: map['deliveryTime'] as String,
      description: map['description'] as String,
    );
  }

  const ProductEntity.empty()
      : this(
    id: 'empty.id',
    name: 'empty.name',
    video: 'empty.video',
    images: const['empty.images'],
    inCart: 16,
    sold: 10,
    quantity: 59,
    price: 20000000,
    deliveryTime: 'deliveryTime.empty',
    description: '',
  );
final String id;
  final String name;
  final String video;
  final List<String> images;
  final int inCart;
  final int sold;
  final int quantity;
  final double price;
  final String deliveryTime;
  final String description;

  @override
  List<Object> get props => [id, name, images, price, description];

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
