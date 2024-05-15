import 'package:carentalapp/components/drawer_tile.dart';
import 'package:carentalapp/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:carentalapp/pages/settings_page.dart';
import 'package:carentalapp/pages/profile_page.dart';

class ListDrawer extends StatelessWidget {
  const ListDrawer({Key? key});

  void logout() {
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          // app logo
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
                'lib/images/logo/gorent.png', // Corrected asset path
                fit: BoxFit.fill,
              ),
            ),
          ),

          // divider line
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),

          // home list tile
          DrawerTile(
            text: "H O M E",
            icon: Icons.home,
            onTap: () => Navigator.pop(context),
          ),

          // home list tile
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

          // settings list tile
          DrawerTile(
            text: "S E T T I N G S",
            icon: Icons.settings,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),

          const Spacer(),

          // logout list tile
          DrawerTile(
            text: "L O G O U T",
            icon: Icons.logout,
            onTap: () {
              logout();
              Navigator.pop(context);
            },
          ),

          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
