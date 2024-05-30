import 'package:carentalapp/models/go_rent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Receipt extends StatelessWidget {
  const Receipt({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right:25, bottom: 25, top: 50),
      child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Thank you for Renting!"),

          const SizedBox(height: 25),

          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.secondary),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(25),
            child: Consumer<GoRent>(
              builder: (context, gorent, child) => 
              Text(gorent.displayCartReceipt()),
            ) ,
          ),

          const SizedBox(height: 25),
          const Text("Estimated delivery time is around 20-40 minutes")
        ],
      ),
    ),
   );
  }
}