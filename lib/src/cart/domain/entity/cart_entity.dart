import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  const CartEntity({
    required this.products,
    required this.quantity,
    required this.farmerId,
    required this.deliveryDate,
  });

  final String products;
  final int quantity;
  final String farmerId;
  final String deliveryDate;

  @override
  List<Object> get props => [products, quantity, farmerId, deliveryDate];
}
