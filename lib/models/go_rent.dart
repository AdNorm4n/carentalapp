import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carentalapp/models/car.dart';
import 'package:carentalapp/models/cart_item.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:collection/collection.dart';

class GoRent extends ChangeNotifier {
  List<Car> _menu = [];
  final List<CartItem> _cart = [];
  String _deliveryAddress = '182G, Jln Beverly Heights 4';
  double _bookingFee = 0.0;

  DateTimeRange? _bookingPeriod;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  GoRent() {
    fetchCars();
  }

  List<Car> get menu => _menu;
  List<CartItem> get cart => _cart;
  String get deliveryAddress => _deliveryAddress;
  double get bookingFee => _bookingFee;
  DateTimeRange? get bookingPeriod => _bookingPeriod;
  TimeOfDay? get startTime => _startTime;
  TimeOfDay? get endTime => _endTime;

  void fetchCars() {
    FirebaseFirestore.instance
        .collection('cars')
        .snapshots()
        .listen((snapshot) {
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

  double getTotalBookingPrice() {
    double total = 0.0;
    if (_bookingPeriod != null && _startTime != null && _endTime != null) {
      for (CartItem cartItem in _cart) {
        final durationHours =
            (_bookingPeriod!.end.difference(_bookingPeriod!.start).inHours +
                    _endTime!.hour -
                    _startTime!.hour)
                .toDouble();
        total += cartItem.car.price * cartItem.quantity * durationHours;
      }
      total += _bookingFee;
    }
    return total;
  }

  void calculateBookingFee() {
    int numberOfCars = _cart.length;
    _bookingFee = numberOfCars > 1 ? 100.0 : 50.0;
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  void updateDeliveryAddress(String newAddress) {
    _deliveryAddress = newAddress;
    notifyListeners();
  }

  void setBookingDetails(
      DateTimeRange? bookingPeriod, TimeOfDay? startTime, TimeOfDay? endTime) {
    _bookingPeriod = bookingPeriod;
    _startTime = startTime;
    _endTime = endTime;
    calculateBookingFee();
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
    receipt.writeln("Total: ${_formatPrice(getTotalBookingPrice())}");
    receipt.writeln("Booking Fee: ${_formatPrice(_bookingFee)}");
    receipt.writeln();

    receipt.writeln("Delivery Location : $deliveryAddress");

    return receipt.toString();
  }

  String _formatPrice(double price) {
    return "RM${price.toStringAsFixed(2)}";
  }

  Map<String, dynamic> getBookingDetails() {
    List<Map<String, dynamic>> items = _cart.map((cartItem) {
      return {
        'item': "${cartItem.quantity} x ${cartItem.car.name}",
        'subtotal': _formatPrice(cartItem.car.price),
        
        'total': _formatPrice(cartItem.car.price *
            cartItem.quantity *
            (_bookingPeriod!.end.difference(_bookingPeriod!.start).inHours +
                    _endTime!.hour -
                    _startTime!.hour)
                .toDouble()),
      };
    }).toList();

    return {
      'booking':
          "Here's your receipt. ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())}",
      'total_price': {
        'items': items,
        'total': _formatPrice(getTotalBookingPrice()),
      },
      'location': deliveryAddress,
      'booking_fee': _formatPrice(_bookingFee),
      'status': 'Active', // Default status for new bookings
      'userId': FirebaseAuth.instance.currentUser?.uid ?? '',
    };
  }

  Future<void> createBooking() async {
    final bookingDetails = getBookingDetails();
    final bookingRef = await FirebaseFirestore.instance
        .collection('bookings')
        .add(bookingDetails);
    bookingRef.update({'id': bookingRef.id}); // Store the document ID
    clearCart();
    notifyListeners();
  }

  void addCar(Car newCar) {
    String ownerId = FirebaseAuth.instance.currentUser?.uid ?? '';
    newCar.ownerId = ownerId;

    FirebaseFirestore.instance
        .collection('cars')
        .add(newCar.toMap())
        .then((docRef) {
      newCar.id = docRef.id;

      newCar.category = CarCategory.values[newCar.category.index];
      newCar.features = CarFeatures.values[newCar.features.index];
      newCar.fuel = CarFuel.values[newCar.fuel.index];
      newCar.trans = CarTrans.values[newCar.trans.index];
      newCar.seater = CarSeater.values[newCar.seater.index];

      _menu.add(newCar);
      notifyListeners();
    });
  }

  void removeCar(String carId) {
    FirebaseFirestore.instance.collection('cars').doc(carId).delete().then((_) {
      _menu.removeWhere((car) => car.id == carId);
      notifyListeners();
    });
  }

  void clearUserCars(String userId) {
    FirebaseFirestore.instance
        .collection('cars')
        .where('ownerId', isEqualTo: userId)
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        doc.reference.delete();
      }
      _menu.removeWhere((car) => car.ownerId == userId);
      notifyListeners();
    });
  }

  void updateBookingStatus(String bookingId, String status) {
    FirebaseFirestore.instance.collection('bookings').doc(bookingId).update({
      'status': status,
    }).then((_) {
      notifyListeners();
    });
  }

  Stream<QuerySnapshot> getBookingsByStatus(String status) {
    return FirebaseFirestore.instance
        .collection('bookings')
        .where('status', isEqualTo: status)
        .snapshots();
  }

  Stream<QuerySnapshot> getBookingsByStatuses(List<String> statuses) {
    return FirebaseFirestore.instance
        .collection('bookings')
        .where('status', whereIn: statuses)
        .snapshots();
  }

  Stream<QuerySnapshot> getUserBookingsByStatuses(List<String> statuses) {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    return FirebaseFirestore.instance
        .collection('bookings')
        .where('userId', isEqualTo: userId)
        .where('status', whereIn: statuses)
        .snapshots();
  }

  Future<void> endRide(DocumentSnapshot booking) async {
    try {
      await FirebaseFirestore.instance
          .collection('bookings')
          .doc(booking.id)
          .update({
        'status': 'Completed',
      });
      notifyListeners();
    } catch (e) {
      print("Failed to end ride: $e");
    }
  }
}
