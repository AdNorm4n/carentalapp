import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? selectedValue;
  final List<T> items;
  final String hintText;
  final ValueChanged<T?>? onChanged;

  const CustomDropdown({
    required this.selectedValue,
    required this.items,
    required this.hintText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360, // Adjust the width as needed
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.inversePrimary),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButtonFormField<T>(
        value: selectedValue,
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
          hintText: hintText,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        items: items.map<DropdownMenuItem<T>>((T value) {
          return DropdownMenuItem<T>(
            value: value,
            child: Container(
              height: 25,// Adjust the height of each item
              alignment: Alignment.centerLeft,
              child: Text(value.toString().split('.').last),
            ),
          );
        }).toList(),
      ),
    );
  }
}
