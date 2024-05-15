// SPRINT 1

import 'package:flutter/material.dart';

class RoleDropdown extends StatelessWidget {
  final String selectedRole;
  final ValueChanged<String?>? onChanged;

  const RoleDropdown({required this.selectedRole, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360, // Adjust the width as needed
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.inversePrimary),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedRole,
        onChanged: onChanged,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0), // Adjust horizontal padding
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary),
            borderRadius: BorderRadius.circular(8.0),
          ),
          hintText: 'Select Role',
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        items: ['Customer', 'Renter'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Container(
              height: 15, // Adjust the height of each item
              alignment: Alignment.centerLeft,
              child: Text(value),
            ),
          );
        }).toList(),
      ),
    );
  }
}
