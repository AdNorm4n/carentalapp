import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  // get collection of bookings
  final CollectionReference bookings = 
      FirebaseFirestore.instance.collection('bookings');

  // save order to db
  Future<void> saveOrderToDatabase(String receipt) async {
    await bookings.add({
      'date': DateTime.now(),
      'bookings': receipt,
    });
  }
}