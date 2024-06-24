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
        padding: const EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // booking fee for 1 car/receipt
            Column(children: [
              Text(
                "\RM50.00",
                style: myPrimaryTextStyle,
              ),
              Text(
                "Booking fee (1 car)",
                style: mySecondaryTextStyle,
              ),
            ]),

            // booking fee for more than 1 car/receipt
            Column(
              children: [
                Text(
                  '\RM100.00',
                  style: myPrimaryTextStyle,
                ),
                Text(
                  'Booking fee (multiple cars)',
                  style: mySecondaryTextStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
