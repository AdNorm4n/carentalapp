// SPRINT 1

import 'package:carentalapp/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:carentalapp/pages/signup_page.dart';

class LoginOrSignup extends StatefulWidget {
  const LoginOrSignup({super.key});

  @override
  State<LoginOrSignup> createState() => _LoginOrSignupState();
}

class _LoginOrSignupState extends State<LoginOrSignup> {
  // initially, show login page
  bool showLoginPage = true;

  // toggle between login and signup page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePages);
    } else {
      return SignPage(onTap: togglePages);
    }
    }
}