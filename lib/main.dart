// main.dart

import 'package:carentalapp/firebase_options.dart';
import 'package:carentalapp/models/go_rent.dart';
import 'package:carentalapp/pages/home_page.dart';
import 'package:carentalapp/pages/login_page.dart';
import 'package:carentalapp/pages/renter_page.dart';
import 'package:carentalapp/services/auth/auth_gate.dart';
import 'package:carentalapp/pages/signup_page.dart';
import 'package:carentalapp/pages/add_car_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:carentalapp/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GoRent(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        '/login': (context) => LoginPage(onTap: () {
              Navigator.pushNamed(context, '/signup');
            }),
        '/signup': (context) => SignPage(onTap: () {}),
        '/renter_page': (context) => const RenterPage(),
        '/home_page': (context) => const HomePage(),
        '/add_car': (context) => AddCarPage(),
        '/car_list': (context) => const HomePage(),
      },
    );
  }
}
