import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/product_manager/domain/entity/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';
@JsonSerializable()
class ProductModel extends ProductEntity {
  const ProductModel({
    required super.name,
    required super.sellerName,
    required super.sellerEmail,
    required super.sellerId,
    required super.quantityAvailable,
    required super.price,
    required super.deliveryDate,
    required super.description,
    required super.measurement,
    required super.images,
    required super.deliveryLocations,
    required super.category,
    super.video,
    super.isLive,
    super.numberSold,
    super.id,
    super.isAlwaysAvailable,
    super.rating,
    super.likes,
  });

  factory ProductModel.fromJson(DataMap json) => _$ProductModelFromJson(json);

  @override
  DataMap toJson() => _$ProductModelToJson(this);

  static const empty = ProductModel(
    name: '',
    images: [],
    price: 0,
    description: '',
    deliveryLocations: [],
    likes: 5,
    measurement: '',
    sellerEmail: '',
    sellerName: '',
    sellerId: '',
    category: '',
    deliveryDate: '',
    quantityAvailable: 0,
  );

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
