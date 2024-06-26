// signup_page.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carentalapp/components/buttons.dart';
import 'package:carentalapp/components/role_dropdown.dart';
import 'package:carentalapp/components/textfields.dart';

class SignPage extends StatefulWidget {
  final void Function()? onTap;

  const SignPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  late String _selectedRole;

  @override
  void initState() {
    super.initState();
    _selectedRole = 'Customer'; // Default role
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  Future<void> register() async {
    if (!_isEmailValid(emailController.text)) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Invalid email format!"),
        ),
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Passwords don't match!"),
        ),
      );
      return;
    }

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      await addUserDetails(
        firstNameController.text.trim(),
        lastNameController.text.trim(),
        emailController.text.trim(),
        _selectedRole,
        userCredential.user!.uid,
      );

      // Determine where to navigate based on role
      if (_selectedRole == 'Renter') {
        Navigator.pushNamed(context, '/renter_page');
      } else {
        Navigator.pushNamed(context, '/home_page');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("Email already in use!"),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.message!),
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  Future<void> addUserDetails(String firstName, String lastName, String email,
      String role, String uid) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'role': role,
      });
    } catch (e) {
      print('Error adding user details: $e');
    }
  }

  bool _isEmailValid(String email) {
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegExp.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Let's create a free GoRent account for you",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                const SizedBox(height: 25),
                Textfields(
                  controller: firstNameController,
                  hintText: "First Name",
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                Textfields(
                  controller: lastNameController,
                  hintText: "Last Name",
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                Textfields(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                Textfields(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                Textfields(
                  controller: confirmPasswordController,
                  hintText: "Confirm password",
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                RoleDropdown(
                  selectedRole: _selectedRole,
                  onChanged: (role) {
                    setState(() {
                      _selectedRole = role!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Buttons(
                  text: "Sign Up",
                  onTap: register,
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        "Login now",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
