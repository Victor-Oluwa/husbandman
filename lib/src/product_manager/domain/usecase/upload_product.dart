import 'package:equatable/equatable.dart';
import 'package:husbandman/core/common/app/entities/product_entity.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/product_manager/domain/repo/product_manager_repo.dart';

class UploadProduct
    extends UseCaseWithParams<ProductEntity, UploadProductParams> {
  const UploadProduct(this._productManagerRepo);

  final ProductManagerRepo _productManagerRepo;

  @override
  ResultFuture<ProductEntity> call(UploadProductParams params) =>
      _productManagerRepo.uploadProduct(
        name: params.name,
        video: params.video,
        image: params.image,
        sellerName: params.sellerName,
        sellerEmail: params.sellerEmail,
        available: params.available,
        sold: params.sold,
        quantity: params.quantity,
        price: params.price,
        deliveryTime: params.deliveryTime,
        description: params.description,
        measurement: params.measurement,
        alwaysAvailable: params.alwaysAvailable,
        deliveryLocation: params.deliveryLocation,
        rating: params.rating,
        likes: params.likes,
      );
}

class UploadProductParams extends Equatable {
  const UploadProductParams({
    required this.name,
    required this.video,
    required this.image,
    required this.sellerName,
    required this.sellerEmail,
    required this.available,
    required this.sold,
    required this.quantity,
    required this.price,
    required this.deliveryTime,
    required this.description,
    required this.measurement,
    required this.alwaysAvailable,
    required this.deliveryLocation,
    required this.rating,
    required this.likes,
  });

  UploadProductParams.empty()
      : this(
          image: ['empty.images'],
          deliveryLocation: ['empty.deliveryLocations'],
          price: 0,
          video: 'empty.video',
          sold: 0,
          quantity: 0,
          deliveryTime: 'empty.deliveryTime',
          description: 'empty.description',
          name: 'empty.name',
          sellerName: 'empty.name',
          sellerEmail: 'empty.email',
          rating: [],
          measurement: 'measurement.empty',
          likes: 4,
          available: true,
          alwaysAvailable: true,
        );

  final String name;
  final String video;
  final List<String> image;
  final String sellerName;
  final String sellerEmail;
  final bool available;
  final int sold;
  final int quantity;
  final double price;
  final String deliveryTime;
  final String description;
  final String measurement;
  final bool alwaysAvailable;
  final List<String> deliveryLocation;
  final List<int> rating;
  final int likes;

  @override
  List<Object?> get props => [
        name,
        image,
        sellerEmail,
        description,
        price,
        video,
        sellerName,
        available,
        sold,
        quantity,
        deliveryTime,
        measurement,
        alwaysAvailable,
        deliveryLocation,
        rating,
        likes,
      ];
}
