import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carentalapp/models/go_rent.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
                          "Are you sure you want to remove all your cars?"),
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
                    ? Center(
                        child: const Text("No cars registered.."),
                      )
                    : ListView.builder(
                        itemCount: userCars.length,
                        itemBuilder: (context, index) {
                          final car = userCars[index];
                          return ListTile(
                            leading: Image.network(car.imageUrl),
                            title: Text(car.name),
                            subtitle: Text('RM${car.price}/hour'),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                gorent.removeCar(car.id);
                              },
                            ),
                          );
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
