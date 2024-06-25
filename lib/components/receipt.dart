import 'package:carentalapp/models/go_rent.dart';
import 'package:carentalapp/pages/booking_history_page.dart';
import 'package:carentalapp/pages/home_page.dart';
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
                      Text("-------"), // Add dashes here
                      const SizedBox(height: 10),
                      ...bookingDetails['total_price']['items'].map<Widget>(
                        (item) {
                          return Text(
                              '${item['item']}: ${item['subtotal']} (Subtotal: ${item['total']})');
                        },
                      ).toList(),
                      const SizedBox(height: 10),
                      Text("-------"), // Add dashes here
                      Text(
                          'Booking Fee: ${bookingDetails['booking_fee']}'), // Display booking fee
                      Text(
                          'Grand Total: ${bookingDetails['total_price']['total']}'), // Display total price before booking price
                      Text("-------"), // Add dashes here
                      const SizedBox(height: 10),
                      Text('Delivery Location: ${bookingDetails['location']}'),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Check your booking status here",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                const SizedBox(height: 20),
                IconButton(
                  icon: const Icon(Icons.book_online),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingHistoryPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(
              indent: 25,
              endIndent: 25,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Book more rides with us!",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                const SizedBox(height: 20),
                IconButton(
                  icon: const Icon(Icons.home),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
