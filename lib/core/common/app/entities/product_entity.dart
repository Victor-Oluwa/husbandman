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
}
