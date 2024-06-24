import 'package:carentalapp/models/go_rent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Receipt extends StatelessWidget {
  const Receipt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 50),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Thank you for booking with GoRent"),
            const SizedBox(height: 25),
            Container(
              decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).colorScheme.secondary),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(25),
              child: Consumer<GoRent>(
                builder: (context, gorent, child) {
                  final bookingDetails = gorent.getBookingDetails();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(bookingDetails['booking']),
                      const SizedBox(height: 10),
                      ...bookingDetails['total_price']['items'].map<Widget>(
                        (item) {
                          return Text(
                              '${item['item']}: ${item['subtotal']} (SubTotal: ${item['total']})');
                        },
                      ).toList(),
                      const SizedBox(height: 10),
                      Text(
                          'Booking Fee: ${bookingDetails['booking_fee']}'), // Display booking fee
                      const SizedBox(height: 10),
                      Text(
                          'Grand Total: ${bookingDetails['total_price']['total']}'),
                      const SizedBox(height: 10),
                      Text('Delivery Location: ${bookingDetails['location']}'),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
