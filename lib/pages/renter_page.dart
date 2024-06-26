import 'package:carentalapp/pages/home_page.dart';
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
                  'Welcome Renter! Rent out your cars today',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.inversePrimary,
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
                IconButton(
                  icon: const Icon(Icons.home),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
