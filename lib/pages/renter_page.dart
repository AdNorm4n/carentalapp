import 'package:flutter/material.dart';
import 'package:carentalapp/components/buttons.dart';
import 'package:carentalapp/pages/manage_car_page.dart'; // Import your manage car page
import 'package:carentalapp/pages/add_car_page.dart'; // Import your add car page

class RenterPage extends StatelessWidget {
  const RenterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Renter Page'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Text(
                  'This is the renter page',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Buttons(
                  text: 'Manage Your Car',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ManageCarPage()));
                  },
                ),
                SizedBox(height: 10),
                Buttons(
                  text: 'Register Your Car',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddCarPage()));
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
