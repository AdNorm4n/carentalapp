import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:carentalapp/models/go_rent.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bookingData['booking'],
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
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
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirm End Ride'),
                              content: Text(
                                  'Are you sure you want to end the ride?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    await goRent.endRide(booking);
                                  },
                                  child: Text('Yes'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('End Ride'),
                    ),
                ],
              ),
            ),
            Column(
              children: items.map((item) {
                final itemData = item as Map<String, dynamic>;
                final carImageUrl = itemData['car_image_url'] ?? '';

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: carImageUrl.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: carImageUrl,
                            placeholder: (context, url) => Container(
                              height: 100,
                              width: 100,
                              color: Theme.of(context).colorScheme.background,
                              child: const Center(
                                  child: CircularProgressIndicator()),
                            ),
                            errorWidget: (context, url, error) => Container(
                              height: 100,
                              width: 100,
                              color: Theme.of(context).colorScheme.background,
                              child: const Icon(Icons.image_not_supported),
                            ),
                            height: 100,
                            width: 100,
                          ),
                        )
                      : Container(
                          height: 100,
                          width: 100,
                          color: Theme.of(context).colorScheme.background,
                          child: const Icon(Icons.image_not_supported),
                        ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
