import 'package:carentalapp/models/car.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carentalapp/models/go_rent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'edit_car_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ManageCarPage extends StatelessWidget {
  const ManageCarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GoRent>(
      builder: (context, gorent, child) {
        final currentUser = FirebaseAuth.instance.currentUser;
        final userCars = gorent.menu
            .where((car) => car.ownerId == currentUser?.uid)
            .toList();

        return Scaffold(
          appBar: AppBar(
            title: const Text("Manage Your Cars"),
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                          "Are you sure you want to remove all your car(s)?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            gorent.clearUserCars(currentUser?.uid ?? '');
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.delete),
              )
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: userCars.isEmpty
                    ? const Center(
                        child: Text("No cars registered.."),
                      )
                    : ListView.builder(
                        itemCount: userCars.length,
                        itemBuilder: (context, index) {
                          final car = userCars[index];
                          return ManageCarTile(car: car);
                        },
                      ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        );
      },
    );
  }
}

class ManageCarTile extends StatelessWidget {
  final Car car;

  const ManageCarTile({Key? key, required this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Car image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: car.imageUrl,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    height: 120,
                    width: 130,
                  ),
                ),

                const SizedBox(width: 10),

                // Name and price
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Car name
                      Text(
                        car.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),

                      // Car price
                      Text(
                        'RM${car.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Edit and Delete buttons
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditCarPage(carId: car.id),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text(
                                "Are you sure you want to remove this car?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Provider.of<GoRent>(context, listen: false)
                                      .removeCar(car.id);
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
