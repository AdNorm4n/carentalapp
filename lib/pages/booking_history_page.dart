import 'package:carentalapp/pages/active_booking_page.dart';
import 'package:carentalapp/pages/completed_booking_page.dart';
import 'package:flutter/material.dart';
import 'package:carentalapp/components/buttons.dart';

class BookingHistoryPage extends StatelessWidget {
  const BookingHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking History Page'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Text(
                  'This is the booking history page',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Buttons(
                  text: 'Active Booking',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ActiveBookingPage()));
                  },
                ),
                SizedBox(height: 10),
                Buttons(
                  text: 'Completed Booking',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CompletedBookingPage()));
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home_page');
                  },
                  child: Text('Go Home'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
