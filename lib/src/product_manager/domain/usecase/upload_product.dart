import 'package:equatable/equatable.dart';
import 'package:husbandman/src/product_manager/domain/entity/product_entity.dart';
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
        sellerName: params.sellerName,
        sellerEmail: params.sellerEmail,
        sellerId: params.sellerId,
        video: params.video,
        image: params.image,
        isLive: params.isLive,
        quantityAvailable: params.quantityAvailable,
        price: params.price,
        deliveryDate: params.deliveryDate,
        description: params.description,
        measurement: params.measurement,
        isAlwaysAvailable: params.isAlwaysAvailable,
        deliveryLocations: params.deliveryLocations,
        category: params.category,);

}

class UploadProductParams extends Equatable {

  const UploadProductParams({
    required this.name,
    required this.sellerName,
    required this.sellerEmail,
    required this.sellerId,
    required this.video,
    required this.image,
    required this.isLive,
    required this.quantityAvailable,
    required this.price,
    required this.deliveryDate,
    required this.description,
    required this.measurement,
    required this.isAlwaysAvailable,
    required this.deliveryLocations,
    required this.category
  });

  static const empty = UploadProductParams(
    isAlwaysAvailable: false,
    image: [''],
    deliveryLocations: [],
    price: 0,
    video: '',
    quantityAvailable: 0,
    deliveryDate: '',
    description: '',
    name: '',
    sellerName: '',
    sellerEmail: '',
    measurement: '',
    category: '',
    sellerId: '', isLive: true,
  );

  final String name;
  final String video;
  final List<String> image;
  final String sellerName;
  final String sellerEmail;
  final String sellerId;
  final bool isLive;
  final int quantityAvailable;
  final double price;
  final String deliveryDate;
  final String description;
  final String measurement;
  final bool isAlwaysAvailable;
  final List<String> deliveryLocations;
  final String category;

  @override
  List<Object?> get props =>
      [
        name,
        image,
        sellerEmail,
        sellerId,
        description,
        price,
        video,
        sellerName,
        isLive,
        quantityAvailable,
        deliveryDate,
        measurement,
        isAlwaysAvailable,
        deliveryLocations,
        category,
      ];
}
