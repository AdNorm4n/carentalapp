import 'package:flutter/material.dart';
import 'package:carentalapp/components/booking_tab_bar.dart';

class BookingHistoryPage extends StatefulWidget {
  const BookingHistoryPage({Key? key}) : super(key: key);

  @override
  _BookingHistoryPageState createState() => _BookingHistoryPageState();
}

class _BookingHistoryPageState extends State<BookingHistoryPage>
    with SingleTickerProviderStateMixin {
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

  /* List<Car> _filterBookingsByCategory(bool isUpcoming, List<Car> fullBookings) {
    // Simulated filtering logic
    return fullBookings.where((car) => car.isUpcoming == isUpcoming).toList();
  }

  List<Widget> getBookingsInThisCategory(List<Car> fullBookings) {
    return [true, false].map((isUpcoming) {
      List<Car> categoryBookings = _filterBookingsByCategory(isUpcoming, fullBookings);

      return ListView.builder(
        itemCount: categoryBookings.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final car = categoryBookings[index];
          return CarTile(
            car: car,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CarPage(car: car),
              ),
            ),
          );
        },
      );
    }).toList();
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: const Text('Booking History'),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: BookingTabBar(tabController: _tabController),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            // Placeholder widgets for each tab
            Center(child: Text('Active Bookings')),
            Center(child: Text('Completed Bookings')),
          ],
        ),
      ),
    );
  }
}
