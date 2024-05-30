import 'package:carentalapp/components/quantity_selector.dart';
import 'package:carentalapp/models/cart_item.dart';
import 'package:carentalapp/models/go_rent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartTile extends StatelessWidget {
  final CartItem cartItem;

  const CartTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<GoRent>(
      builder: (context, gorent, child) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // car image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      cartItem.car.imagePath,
                      height: 120,
                      width: 130,
                    ),
                  ),
              
                  const SizedBox(width: 10),
              
                  // name and price 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // car name
                      Text(cartItem.car.name),
              
                      // car price
                      Text(
                        'RM${cartItem.car.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),

                      // decrement quantity
                  QuantitySelector(
                    quantity: cartItem.quantity, 
                    car: cartItem.car, 
                    onDecrement: () {
                      gorent.removeFromCart(cartItem);
                    },
                  ),

                  const SizedBox(width: 10),

                    ],
                  ),
                  
                  const Spacer(),
            
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
