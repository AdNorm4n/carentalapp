// SPRINT 3

import 'package:flutter/material.dart';

class CurrentLocation extends StatelessWidget {
  const CurrentLocation({super.key});

  void openLocationSearchBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Your current location"),
        content: const TextField(
          decoration: InputDecoration(hintText: "Search address.."),
      ),
      actions: [
        // cancel button
        MaterialButton(onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'), 
        ),

        // save button
        MaterialButton(onPressed: () => Navigator.pop(context),
        child: const Text('Save'), 
        ),
      ],
     ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pick location", 
            style: TextStyle(color: Theme.of(context).colorScheme.primary),  
          ),
          GestureDetector(
            onTap: () => openLocationSearchBox(context),
            child: Row(
              children: [
              // address
              Text(
                "138A, Jln Beverly Heights 1",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
              ),
              ),
                  
              // drop down menu
              Icon(Icons.keyboard_arrow_down_rounded),
            ],
            ),
          ),
        ],
      ),
    );
  }
}