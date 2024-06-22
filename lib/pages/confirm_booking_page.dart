import 'package:carentalapp/pages/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:carentalapp/components/buttons.dart';

class ConfirmBookingPage extends StatelessWidget {
  const ConfirmBookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Booking Page'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Text(
                  'This is the confirm booking page',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Buttons(
                  text: 'Checkout now',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PaymentPage()));
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
