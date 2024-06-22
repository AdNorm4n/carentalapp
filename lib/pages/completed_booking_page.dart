import 'package:flutter/material.dart';

class CompletedBookingPage extends StatefulWidget {
  const CompletedBookingPage({super.key});

  @override
  State<CompletedBookingPage> createState() => _CompletedBookingPageState();
}

class _CompletedBookingPageState extends State<CompletedBookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Completed Booking Page"),
      ),
    );
  }
}
