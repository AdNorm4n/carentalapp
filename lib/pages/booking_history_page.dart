import 'package:carentalapp/components/booking_history_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carentalapp/models/go_rent.dart';
import 'package:carentalapp/components/booking_tab_bar.dart';

class BookingHistoryPage extends StatefulWidget {
  const BookingHistoryPage({Key? key}) : super(key: key);

  @override
  _BookingHistoryPageState createState() => _BookingHistoryPageState();
}

class _BookingHistoryPageState extends State<BookingHistoryPage>
    with SingleTickerProviderStateMixin {
  // tab bar controller
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final goRent = Provider.of<GoRent>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: const Text('Booking History'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: BookingTabBar(tabController: _tabController),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          BookingHistoryList(
            stream: goRent.getUserBookingsByStatuses(['Active']),
          ),
          BookingHistoryList(
            stream: goRent.getUserBookingsByStatuses(['Completed']),
          ),
        ],
      ),
    );
  }
}
