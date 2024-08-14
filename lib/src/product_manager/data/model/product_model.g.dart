// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      name: json['name'] as String,
      sellerName: json['sellerName'] as String,
      sellerEmail: json['sellerEmail'] as String,
      sellerId: json['sellerId'] as String,
      quantityAvailable: (json['quantityAvailable'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
      deliveryDate: json['deliveryDate'] as String,
      description: json['description'] as String,
      measurement: json['measurement'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      deliveryLocations: (json['deliveryLocations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      category: json['category'] as String,
      video: json['video'] as String? ?? '',
      isLive: json['isLive'] as bool? ?? true,
      numberSold: (json['numberSold'] as num?)?.toInt() ?? 0,
      id: json['_id'] as String? ?? '',
      isAlwaysAvailable: json['isAlwaysAvailable'] as bool? ?? false,
      rating: (json['rating'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      likes: (json['likes'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'sellerName': instance.sellerName,
      'sellerEmail': instance.sellerEmail,
      'sellerId': instance.sellerId,
      'video': instance.video,
      'images': instance.images,
      'isLive': instance.isLive,
      'numberSold': instance.numberSold,
      'quantityAvailable': instance.quantityAvailable,
      'price': instance.price,
      'deliveryDate': instance.deliveryDate,
      'description': instance.description,
      'measurement': instance.measurement,
      'isAlwaysAvailable': instance.isAlwaysAvailable,
      'deliveryLocations': instance.deliveryLocations,
      'rating': instance.rating,
      'likes': instance.likes,
      'category': instance.category,
    };
