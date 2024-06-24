import 'package:carentalapp/components/app_bar.dart';
import 'package:carentalapp/components/current_location.dart';
import 'package:carentalapp/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carentalapp/models/go_rent.dart';
import 'package:carentalapp/components/car_tile.dart';
import 'package:carentalapp/components/description_box.dart';
import 'package:carentalapp/components/tab_bar.dart';
import 'package:carentalapp/models/car.dart';
import 'package:carentalapp/pages/car_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // tab bar controller
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: CarCategory.values.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // sort out and return a list of car that belong to a specific category
  List<Car> _filterMenuByCategory(CarCategory category, List<Car> fullMenu) {
    return fullMenu.where((car) => car.category == category).toList();
  }

  // return list of cars in given category
  List<Widget> getCarInThisCategory(List<Car> fullMenu) {
    return CarCategory.values.map((category) {
      // get category menu
      List<Car> categoryMenu = _filterMenuByCategory(category, fullMenu);

      return ListView.builder(
        itemCount: categoryMenu.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsetsDirectional.zero,
        itemBuilder: (context, index) {
          // get individual car
          final car = categoryMenu[index];

          // return car title UI
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      drawer: const ListDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          HomeAppBar(
            title: HomeTabBar(tabController: _tabController),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // my location
                const CurrentLocation(),

                // dbooking fee
                DescriptionBox(),
              ],
            ),
          ),
        ],
        body: Consumer<GoRent>(
          builder: (context, gorent, child) => TabBarView(
            controller: _tabController,
            children: getCarInThisCategory(gorent.menu),
          ),
        ),
      ),
    );
  }
}
