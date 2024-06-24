// auth_gate.dart

import 'package:carentalapp/pages/home_page.dart';
import 'package:carentalapp/pages/renter_page.dart';
import 'package:carentalapp/services/auth/login_or_signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            User? user = snapshot.data;
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user!.uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData && snapshot.data!.exists) {
                  String role = snapshot.data!.get('role');
                  if (role == 'Renter') {
                    return const RenterPage();
                  } else {
                    return const HomePage();
                  }
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text(
                          'Error retrieving user data: ${snapshot.error}'));
                } else {
                  return Center(child: Text('User data not found'));
                }
              },
            );
          } else {
            return const LoginOrSignup();
          }
        },
      ),
    );
  }
}
