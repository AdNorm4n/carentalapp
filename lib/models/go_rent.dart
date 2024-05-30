import 'package:carentalapp/models/cart_item.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:carentalapp/models/car.dart';
import 'package:intl/intl.dart';

class GoRent extends ChangeNotifier {
  // list of available cars
  final List<Car> _menu = [
    // economy
    Car(
      name: "Perodua Myvi", 
      description: "Introducing the Myvi: your compact, reliable ride for any journey. Rent now for a stress-free driving experience!", 
      imagePath: "lib/images/economy/myvi.png", 
      price: 10.99, 
      category: CarCategory.economy, 
      features: CarFeatures.hatchback,
      fuel: CarFuel.petrol,
      trans: CarTrans.automatic,
      seater: CarSeater.five,
    ),
    Car(
      name: "Proton X50", 
      description: "Introducing the X50: your adaptable, reliable ride for any adventure. Rent now for a worry-free driving experience!", 
      imagePath: "lib/images/economy/x50.png", 
      price: 15.00, 
      category: CarCategory.economy, 
      features: CarFeatures.suv,
      fuel: CarFuel.petrol,
      trans: CarTrans.automatic,
      seater: CarSeater.five,
    ),

    // sports
    Car(
      name: "Honda HRV", 
      description: "Experience the HRV: your versatile, dependable companion for every trip. Rent now for a seamless driving adventure!", 
      imagePath: "lib/images/sports/hrv.png", 
      price: 20.00, 
      category: CarCategory.sports, 
      features: CarFeatures.suv,
      fuel: CarFuel.petrol,
      trans: CarTrans.automatic,
      seater: CarSeater.five,
    ),
    Car(
      name: "Ford Mustang", 
      description: "Rev up with the Mustang: your dynamic, powerful choice for unforgettable drives. Rent now for an exhilarating journey on the road!", 
      imagePath: "lib/images/sports/mustang.png", 
      price: 40.00, 
      category: CarCategory.sports, 
      features: CarFeatures.coupe,
      fuel: CarFuel.petrol,
      trans: CarTrans.automatic,
      seater: CarSeater.four,
    ),
  
    // luxury
    Car(
      name: "Toyota Alphard", 
      description: "Embark on luxury with the Alphard: your spacious, opulent sanctuary on wheels. Rent now for a lavish driving escapade!", 
      imagePath: "lib/images/luxury/alphard.png", 
      price: 50.00, 
      category: CarCategory.luxury, 
      features: CarFeatures.mpv,
      fuel: CarFuel.petrol,
      trans: CarTrans.automatic,
      seater: CarSeater.seven,
    ),
    Car(
      name: "BMW M2", 
      description: "Unleash the M2: your thrilling, high-performance ride for adrenaline-packed journeys. Rent now for an unmatched driving thrill!", 
      imagePath: "lib/images/luxury/bmw.png", 
      price: 80.00, 
      category: CarCategory.luxury, 
      features: CarFeatures.coupe,
      fuel: CarFuel.petrol,
      trans: CarTrans.manual,
      seater: CarSeater.four,
    ),
    Car(
      name: "Mercedes Benz A200", 
      description: "Step into luxury with the A200: your sophisticated, refined partner for every mile. Rent now for an elegant driving experience!", 
      imagePath: "lib/images/luxury/mercedes.png", 
      price: 40.00, 
      category: CarCategory.luxury, 
      features: CarFeatures.hatchback,
      fuel: CarFuel.petrol,
      trans: CarTrans.automatic,
      seater: CarSeater.five,
    ),
  ];

   // user cart 
  final List<CartItem> _cart = [];
  
  // delivery address (user can change/update)
  String _deliveryAddress = '182G, Jln Beverly Heights 4';

  // GETTERS
  List<Car> get menu => _menu;
  List<CartItem> get cart => _cart;
  String get deliveryAddress => _deliveryAddress;

  /*

  OPERATIONS

  */

  // add to rental cart 
  void addToCart(Car car) {
    // see if there is a cart item already with the same car
    CartItem? cartItem = _cart.firstWhereOrNull((item) => item.car == car);

    // if item already exists, increment the quantity
    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      // otherwise, add a new cart item to the cart
      _cart.add(CartItem(car: car));
    }
    notifyListeners();
  }

  // remove from rental cart
  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }
    notifyListeners();
  }

  // get total price of rental cart
  double getTotalPrice() {
    double total = 0.0;
    for (CartItem cartItem in _cart) {
      total += cartItem.totalPrice;
    }
    return total;
  }

  // get total number of items in rental cart
  int getTotalItemCount() {
    int totalItemCount = 0;
    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }
    return totalItemCount;
  }

  // clear rental cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  // update delivery address
  void updateDeliveryAddress(String newAddress) {
    _deliveryAddress = newAddress;
    notifyListeners();
  }

  /*

  HELPERS

  */

  // generate a receipt 
  String displayCartReceipt() {
    final receipt = StringBuffer();
    receipt.writeln("Here's your receipt.");
    receipt.writeln();

    // format the date to include up to second only 
    String formattedDate = 
    DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("-------");

    for (final cartItem in _cart) {
      receipt.writeln(
        "${cartItem.quantity} x ${cartItem.car.name} - ${_formatPrice(cartItem.car.price)}");
    }

    receipt.writeln("-------");
    receipt.writeln("Total: ${_formatPrice(getTotalPrice())}");
    receipt.writeln();
    receipt.writeln("Delivering to : $deliveryAddress");
    
    return receipt.toString();
  }

  // format double value into money
  String _formatPrice(double price) {
    return "RM${price.toStringAsFixed(2)}";
  }
}