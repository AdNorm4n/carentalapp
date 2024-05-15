// SPRINT 1

import 'package:carentalapp/firebase_options.dart';
import 'package:carentalapp/models/go_rent.dart';
import 'package:carentalapp/services/auth/auth_gate.dart';
import 'package:carentalapp/pages/signup_page.dart';
import 'package:carentalapp/pages/subscribe_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:carentalapp/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(providers: [
      // theme provider
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      ),

      // go rent provider
      ChangeNotifierProvider(
        create: (context) => GoRent(),
      ),
    ],
    child: const MyApp(),
   ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        '/signup': (context) => const SignPage(onTap: null),
        '/renter_subscription': (context) => const SubscribePage(),
      },
    );
  }
}
