import 'package:carentalapp/components/current_location.dart';
import 'package:carentalapp/models/car.dart';
import 'package:carentalapp/models/go_rent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carentalapp/components/buttons.dart';
import 'package:carentalapp/pages/payment_page.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ConfirmBookingPage extends StatefulWidget {
  const ConfirmBookingPage({Key? key}) : super(key: key);

  @override
  _ConfirmBookingPageState createState() => _ConfirmBookingPageState();
}

class _ConfirmBookingPageState extends State<ConfirmBookingPage> {
  DateTimeRange? bookingPeriod; // Booking period range

  @override
  Widget build(BuildContext context) {
    return Consumer<GoRent>(
      builder: (context, gorent, child) {
        final userCart = gorent.cart;

        double totalPrice = userCart.fold(0.0, (sum, item) {
          if (bookingPeriod == null) return sum;
          final durationHours = bookingPeriod!.duration.inHours;
          return sum + (item.car.price * item.quantity * durationHours);
        });

        return Scaffold(
          appBar: AppBar(
            title: const Text("Confirm Booking"),
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CurrentLocation(),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: userCart.length,
                  itemBuilder: (context, index) {
                    final cartItem = userCart[index];
                    return ConfirmCarTile(
                      car: cartItem.car,
                      quantity: cartItem.quantity,
                      bookingPeriod: bookingPeriod,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Select Booking Period',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: 8),
                    // Adjusted ElevatedButton size and style
                    ElevatedButton(
                      onPressed: () async {
                        final picked = await showDateRangePicker(
                          context: context,
                          firstDate:
                              DateTime.now().add(const Duration(hours: 1)),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                        );
                        if (picked != null && picked.duration.inHours > 0) {
                          setState(() {
                            bookingPeriod = picked;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .inversePrimary, // Adjust padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ), // Background color
                      ),
                      child: Text(
                        bookingPeriod == null
                            ? 'Select Dates'
                            : '${DateFormat.yMMMd().format(bookingPeriod!.start)} - ${DateFormat.yMMMd().format(bookingPeriod!.end)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Text(
                      'Total Price: RM${totalPrice.toStringAsFixed(2)}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Buttons(
                      text: 'Checkout now',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PaymentPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ConfirmCarTile extends StatelessWidget {
  final Car car;
  final int quantity;
  final DateTimeRange? bookingPeriod;

  const ConfirmCarTile({
    Key? key,
    required this.car,
    required this.quantity,
    required this.bookingPeriod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double subtotal = bookingPeriod != null
        ? car.price * quantity * bookingPeriod!.duration.inHours
        : 0.0;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    car.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text("Price/hour: RM${car.price.toStringAsFixed(2)}"),
                  Text("Quantity: $quantity"),
                  Text("Subtotal: RM${subtotal.toStringAsFixed(2)}"),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: car.imageUrl,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                height: 120,
                width: 130,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
