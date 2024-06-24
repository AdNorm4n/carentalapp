import 'package:flutter/material.dart';

class BookingTabBar extends StatelessWidget {
  final TabController tabController;

  const BookingTabBar({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  List<Tab> _buildCategoryTabs() {
    return [
      const Tab(text: 'Active'),
      const Tab(text: 'Completed'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBar(
        controller: tabController,
        tabs: _buildCategoryTabs(),
      ),
    );
  }
}
