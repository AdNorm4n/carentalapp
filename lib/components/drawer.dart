// drawer.dart

import 'package:carentalapp/pages/booking_history_page.dart';
import 'package:carentalapp/pages/renter_page.dart';
import 'package:flutter/material.dart';
import 'package:carentalapp/services/auth/auth_service.dart';
import 'package:carentalapp/pages/profile_page.dart';
import 'package:carentalapp/pages/settings_page.dart';
import 'package:carentalapp/components/drawer_tile.dart';

class ListDrawer extends StatelessWidget {
  const ListDrawer({Key? key}) : super(key: key);

  void logout(BuildContext context) async {
    final authService = AuthService();
    try {
      await authService.signOut();
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      // Handle error during logout
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to log out: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 60.0,
              bottom: 10,
            ),
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                color: Theme.of(context).colorScheme.background,
              ),
              child: Image.asset(
                'lib/images/logo/gorent.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          DrawerTile(
            text: "H O M E",
            icon: Icons.home,
            onTap: () => Navigator.pop(context),
          ),
          DrawerTile(
            text: "P R O F I L E",
            icon: Icons.person,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
            },
          ),
          DrawerTile(
            text: "B O O K I N G",
            icon: Icons.history,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingHistoryPage(),
                ),
              );
            },
          ),
          DrawerTile(
            text: "R E N T E R",
            icon: Icons.car_rental,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RenterPage(),
                ),
              );
            },
          ),
          DrawerTile(
            text: "S E T T I N G S",
            icon: Icons.settings,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              );
            },
          ),
          const Spacer(),
          DrawerTile(
            text: "L O G O U T",
            icon: Icons.logout,
            onTap: () {
              Navigator.pop(context);
              logout(context);
            },
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
