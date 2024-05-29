// SPRINT 2
import 'package:carentalapp/components/buttons.dart';
import 'package:carentalapp/models/go_rent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  // Add this import for using Provider
import 'package:carentalapp/models/car.dart';

class CarPage extends StatefulWidget {
  final Car car;

  const CarPage({
    super.key, 
    required this.car,
  });

  @override
  State<CarPage> createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {

  // method to add to cart
  void addToCart(Car car) {
  // close current car page to go back to menu
  Navigator.pop(context);

    // add to cart
    context.read<GoRent>().addToCart(car);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // scaffold UI
        Scaffold(
          appBar: AppBar(
            title: Text(
              'Car Details',
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Car image slightly under the title
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: Center(
                    child: Image.asset(
                      widget.car.imagePath,
                      width: 400,
                    ),
                  ),
                ),
                // Car name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    widget.car.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                // Car price
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    '\RM${widget.car.price.toStringAsFixed(2)}/hour',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
                // Car description
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(widget.car.description),
                ),
                // Car features
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Category: ${widget.car.category.toString().split('.').last}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Feature: ${widget.car.features.toString().split('.').last}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Fuel: ${widget.car.fuel.toString().split('.').last}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Transmission: ${widget.car.trans.toString().split('.').last}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Seater: ${widget.car.seater.toString().split('.').last}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                // Button add to cart
                Buttons(
                  onTap: () => addToCart(widget.car),
                  text: "Add to Rental Cart",
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
