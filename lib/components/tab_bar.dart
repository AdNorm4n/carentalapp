// SPRINT 3/4

import 'package:flutter/material.dart';

class HomeTabBar extends StatelessWidget {
  final TabController tabController;

  const HomeTabBar({
    super.key,
    required this.tabController,
    });
    
    List<Tab> _buildCategoryTabs() {
       return [
       const Tab(text: 'Economy'),
       const Tab(text: 'Sports'),
       const Tab(text: 'Luxury'),
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