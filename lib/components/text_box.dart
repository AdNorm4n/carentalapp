// SPRINT 1

import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onPressed;
  const TextBox({
    super.key, 
    required this.text, 
    required this.sectionName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(
        left: 15, 
        bottom:15,
      ),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // section name
            Text(
              sectionName, style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),

            // edit button
            IconButton(
              onPressed: onPressed, 
              icon: Icon(
                Icons.settings, 
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),

        //text
        Text(text),
      ],
     ),
    );
  }
}