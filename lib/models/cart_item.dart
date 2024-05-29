import 'package:carentalapp/models/car.dart';

class CartItem {
  final Car car; 
  int quantity;

  CartItem({
    required this.car,
    this.quantity = 1,
  });

  double get totalPrice {
    return car.price * quantity;
  }
}
