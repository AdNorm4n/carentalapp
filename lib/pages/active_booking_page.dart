import 'package:flutter/material.dart';

class ActiveBookingPage extends StatefulWidget {
  const ActiveBookingPage({super.key});

  @override
  State<ActiveBookingPage> createState() => _ActiveBookingPageState();
}

class _ActiveBookingPageState extends State<ActiveBookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Active Booking Page"),
      ),
    );
  }
}
