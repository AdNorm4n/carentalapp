// SPRINT 1

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carentalapp/components/text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser!;
  }

  // Function to edit user field
  Future<void> editField(String field, String newValue) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser.uid) // document IDs are user IDs
          .update({field: newValue});
    } catch (e) {
      print("Error updating field: $e");
    }
  }

  void _showEditDialog(String field, String currentValue) {
    TextEditingController controller = TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $field'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter new $field'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                String newValue = controller.text;
                if (newValue.isNotEmpty) {
                  await editField(field, newValue);
                }
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Profile Page"),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(currentUser.uid) // Assuming document IDs are user IDs
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.data() == null) {
            // Document doesn't exist or data is null
            print("No data found or snapshot data is null");
            return const Center(
              child: Text('No data found or snapshot data is null'),
            );
          } else {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            print("UserData: $userData");

            return ListView(
              children: [
                const SizedBox(height: 50),
                // Profile pic
                Icon(
                  Icons.person,
                  size: 100,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                const SizedBox(height: 10),
                // User email
                Text(
                  currentUser.email!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                const SizedBox(height: 35),
                // User details
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    'My Details',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
                // First name
                TextBox(
                  text: userData['firstName'] ?? '', // Display user first name
                  sectionName: 'First Name',
                  onPressed: () => _showEditDialog('firstName', userData['firstName'] ?? ''),
                ),
                // Last name
                TextBox(
                  text: userData['lastName'] ?? '', // Display user last name
                  sectionName: 'Last Name',
                  onPressed: () => _showEditDialog('lastName', userData['lastName'] ?? ''),
                ),
                // Role
                TextBox(
                  text: userData['role'] ?? '', // Display user role
                  sectionName: 'Role',
                  onPressed: null,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
