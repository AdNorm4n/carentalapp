import 'package:carentalapp/pages/car_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carentalapp/models/go_rent.dart';
import 'package:carentalapp/components/drawer.dart';
import 'package:carentalapp/components/car_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:carentalapp/pages/add_car_page.dart';

class RenterHomePage extends StatefulWidget {
  const RenterHomePage({super.key});

  @override
  State<RenterHomePage> createState() => _RenterHomePageState();
}

class _RenterHomePageState extends State<RenterHomePage> {
  String? _userRole;

  @override
  void initState() {
    super.initState();
    _getUserRole();
  }

  Future<void> _getUserRole() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      setState(() {
        _userRole = userDoc['role'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: const Text('Renter Home'),
        actions: [
          if (_userRole == 'Renter')
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, '/add_car');
              },
            ),
        ],
      ),
      drawer: const ListDrawer(),
      body: Consumer<GoRent>(
        builder: (context, gorent, child) {
          return ListView.builder(
            itemCount: gorent.menu.length,
            itemBuilder: (context, index) {
              final car = gorent.menu[index];
              return CarTile(
                car: car,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CarPage(car: car),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
