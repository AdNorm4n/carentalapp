import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carentalapp/models/car.dart';
import 'package:carentalapp/models/cart_item.dart';
import 'package:intl/intl.dart';

class GoRent extends ChangeNotifier {
  List<Car> _menu = [];
  final List<CartItem> _cart = [];
  String _deliveryAddress = '182G, Jln Beverly Heights 4';

  GoRent() {
    fetchCars();
  }

  List<Car> get menu => _menu;
  List<CartItem> get cart => _cart;
  String get deliveryAddress => _deliveryAddress;

  void fetchCars() {
    FirebaseFirestore.instance.collection('cars').snapshots().listen((snapshot) {
      _menu = snapshot.docs.map((doc) => Car.fromFirestore(doc)).toList();
      notifyListeners();
    });
  }

  void addToCart(Car car) {
    CartItem? cartItem = _cart.firstWhereOrNull((item) => item.car == car);

    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      _cart.add(CartItem(car: car, quantity: 1));
    }
    notifyListeners();
  }

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

  double getTotalPrice() {
    double total = 0.0;
    for (CartItem cartItem in _cart) {
      total += cartItem.totalPrice;
    }
    return total;
  }

  int getTotalItemCount() {
    int totalItemCount = 0;
    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }
    return totalItemCount;
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  void updateDeliveryAddress(String newAddress) {
    _deliveryAddress = newAddress;
    notifyListeners();
  }

  String displayCartReceipt() {
    final receipt = StringBuffer();
    receipt.writeln("Here's your receipt.");
    receipt.writeln();

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

  String _formatPrice(double price) {
    return "RM${price.toStringAsFixed(2)}";
  }
}
