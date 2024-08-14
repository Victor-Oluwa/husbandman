// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductEntity _$ProductEntityFromJson(Map<String, dynamic> json) =>
    ProductEntity(
      name: json['name'] as String,
      sellerName: json['sellerName'] as String,
      sellerEmail: json['sellerEmail'] as String,
      sellerId: json['sellerId'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      quantityAvailable: (json['quantityAvailable'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
      deliveryDate: json['deliveryDate'] as String,
      description: json['description'] as String,
      measurement: json['measurement'] as String,
      category: json['category'] as String,
      deliveryLocations: (json['deliveryLocations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      isLive: json['isLive'] as bool? ?? true,
      numberSold: (json['numberSold'] as num?)?.toInt() ?? 0,
      isAlwaysAvailable: json['isAlwaysAvailable'] as bool? ?? false,
      rating: (json['rating'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      video: json['video'] as String? ?? '',
      id: json['_id'] as String? ?? '',
    );

Map<String, dynamic> _$ProductEntityToJson(ProductEntity instance) =>
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
