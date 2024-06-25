// SPRINT 3/4

import 'package:flutter/material.dart';

class DescriptionBox extends StatelessWidget {
  const DescriptionBox({super.key});

  @override
  Widget build(BuildContext context) {
    // textstyle
    var myPrimaryTextStyle =
        TextStyle(color: Theme.of(context).colorScheme.inversePrimary);
    var mySecondaryTextStyle =
        TextStyle(color: Theme.of(context).colorScheme.primary);

    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
          bottom: 25,
          top: 15,
        ),
        child: Column(
          children: [
            // Centered title
            Text(
              "Booking fee rates",
              style: myPrimaryTextStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
                height:
                    20), // Add some spacing between the title and the rows below
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Booking fee for single car
                Column(
                  children: [
                    Text(
                      "RM50.00",
                      style: myPrimaryTextStyle,
                    ),
                    Text(
                      "Single car",
                      style: mySecondaryTextStyle,
                    ),
                  ],
                ),
                // Booking fee for multiple cars
                Column(
                  children: [
                    Text(
                      'RM100.00',
                      style: myPrimaryTextStyle,
                    ),
                    Text(
                      'Multiple cars',
                      style: mySecondaryTextStyle,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
