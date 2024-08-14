import 'package:equatable/equatable.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_entity.g.dart';

@JsonSerializable()
class ProductEntity extends Equatable {
  const ProductEntity({
    required this.name,
    required this.sellerName,
    required this.sellerEmail,
    required this.sellerId,
    required this.images,
    required this.quantityAvailable,
    required this.price,
    required this.deliveryDate,
    required this.description,
    required this.measurement,
    required this.category,
    required this.deliveryLocations,
    this.isLive = true,
    this.numberSold = 0,
    this.isAlwaysAvailable = false,
    this.rating = const [],
    this.likes = 0,
    this.video = '',
    this.id = '',
  });

  factory ProductEntity.fromJson(DataMap json) => _$ProductEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProductEntityToJson(this);

  static const empty = ProductEntity(
    name: '',
    images: [],
    price: 0,
    description: '',
    likes: 5,
    measurement: '',
    sellerEmail: '',
    sellerName: '',
    sellerId: '',
    category: '',
    deliveryDate: '',
    quantityAvailable: 0,
    deliveryLocations: [],
  );

  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String sellerName;
  final String sellerEmail;
  final String sellerId;
  final String video;
  final List<String> images;
  final bool isLive;
  final int numberSold;
  final int quantityAvailable;
  final double price;
  final String deliveryDate;
  final String description;
  final String measurement;
  final bool isAlwaysAvailable;
  final List<String> deliveryLocations;
  final List<int> rating;
  final int likes;
  final String category;

  @override
  List<dynamic> get props => [
        id,
        name,
        sellerName,
        sellerEmail,
        sellerId,
        video,
        quantityAvailable,
        images,
        isLive,
        numberSold,
        price,
        deliveryDate,
        description,
        measurement,
        isAlwaysAvailable,
        deliveryLocations,
        rating,
        likes,
        category,
      ];
}
