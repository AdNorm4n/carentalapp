import 'package:carentalapp/components/quantity_selector.dart';
import 'package:carentalapp/models/cart_item.dart';
import 'package:carentalapp/models/go_rent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
                children: [
                  // Car image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: cartItem.car.imageUrl,
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      height: 120,
                      width: 130,
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Name and price 
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Car name
                        Text(
                          cartItem.car.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),

                        // Car price
                        Text(
                          'RM${cartItem.car.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Quantity selector
                  QuantitySelector(
                    quantity: cartItem.quantity, 
                    car: cartItem.car, 
                    onDecrement: () {
                      gorent.removeFromCart(cartItem);
                    },
                  ),

                  const SizedBox(width: 10),
                  

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
