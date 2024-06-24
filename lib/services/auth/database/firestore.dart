import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carentalapp/models/go_rent.dart';

class FirestoreService {
  Future<void> saveOrderToDatabase(GoRent goRent) async {
    final collection = FirebaseFirestore.instance.collection('bookings');
    final bookingDetails = goRent.getBookingDetails();
    await collection.add(bookingDetails);
  }
}
