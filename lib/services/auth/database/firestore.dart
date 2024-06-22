import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carentalapp/models/go_rent.dart';

class FirestoreService {
  final CollectionReference bookings =
      FirebaseFirestore.instance.collection('bookings');

  Future<void> saveOrderToDatabase(GoRent rent) async {
    Map<String, dynamic> bookingDetails = rent.getBookingDetails();
    await bookings.add({
      'booking': bookingDetails['booking'],
      'total_price': bookingDetails['total_price'],
      'location': bookingDetails['location'],
      'date': bookingDetails['date'],
    });
  }
}
