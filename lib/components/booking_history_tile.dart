import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:carentalapp/models/go_rent.dart';

class BookingHistoryTile extends StatelessWidget {
  final DocumentSnapshot booking;

  const BookingHistoryTile({Key? key, required this.booking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final goRent = Provider.of<GoRent>(context, listen: false);
    final bookingData = booking.data() as Map<String, dynamic>;
    final items = bookingData['total_price']['items'] as List<dynamic>;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bookingData['booking'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            ...items.map((item) {
              final itemData = item as Map<String, dynamic>;
              return Text(
                  '${itemData['item']} - ${itemData['subtotal']} (Subtotal: ${item['total']})');
            }).toList(),
            SizedBox(height: 8.0),
            Text('Booking Fee: ${bookingData['booking_fee']}'),
            Text('Grand Total: ${bookingData['total_price']['total']}'),
            Text('Location: ${bookingData['location']}'),
            Text('Status: ${bookingData['status']}'),
            SizedBox(height: 8.0),
            if (bookingData['status'] != 'Completed')
              ElevatedButton(
                onPressed: () async {
                  await goRent.endRide(booking);
                },
                child: Text('End Ride'),
              ),
          ],
        ),
      ),
    );
  }
}
