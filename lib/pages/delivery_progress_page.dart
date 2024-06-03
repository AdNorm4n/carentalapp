import 'package:carentalapp/components/receipt.dart';
import 'package:carentalapp/models/go_rent.dart';
import 'package:carentalapp/services/auth/database/firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveryProgressPage extends StatefulWidget {
  const DeliveryProgressPage({super.key});

  @override
  State<DeliveryProgressPage> createState() => _DeliveryProgressPageState();
}

class _DeliveryProgressPageState extends State<DeliveryProgressPage> {
  // get access to db
  FirestoreService db = FirestoreService();

  @override
  void initState() {
    super.initState();

    // if we get to this page, submit order to db
    String receipt = context.read<GoRent>().displayCartReceipt();
    db.saveOrderToDatabase(receipt);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Delivery in Progress'),
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
      body: const Column(
        children: [
          Receipt(),
        ],
      ),
    );
  }

  // Custom Bottom Nav Bar - Message / Call Renter
  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
       ),
      ),
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
        // profile picture of renter
        Container(decoration: BoxDecoration(color: Theme.of(context).colorScheme.background,
        shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.person),
        ),
        ),

        const SizedBox(width: 10),

        // renter details
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Adam Iskandar", 
              style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
             Text(
              "Renter",
              style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              ),
             ),
          ],
        ),

        const Spacer(),

        Row(
          children: [
          // message button
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
            shape: BoxShape.circle,
          ),
          child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.message),
          color: Theme.of(context).colorScheme.primary,
          ),
          ),

          const SizedBox(width: 10),

          // call button
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
            shape: BoxShape.circle,
          ),
          child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.call),
          color: Colors.green,
          ),
          ),
          ],)

      ],
      ),
    );
   }
}
