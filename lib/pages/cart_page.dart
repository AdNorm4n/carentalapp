import 'package:carentalapp/components/buttons.dart';
import 'package:carentalapp/components/cart_tile.dart';
import 'package:carentalapp/models/go_rent.dart';
import 'package:carentalapp/pages/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GoRent>(builder: (context, gorent, child) {
      // cart
      final userCart = gorent.cart;

      // scaffold UI
      return Scaffold(
        appBar: AppBar(
          title: const Text("Rental Cart"),
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            // clear cart button
            IconButton(
              onPressed: () {
                showDialog(
                  context: context, 
                  builder: (context) => AlertDialog(
                    title: const Text("Are you sure you want to clear the cart?"),
                    actions: [
                      // cancel button
                      TextButton(
                        onPressed: () => Navigator.pop(context), 
                        child: const Text("Cancel"),
                      ),

                      // yes button
                       TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          gorent.clearCart();
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

            // list of cart
            Expanded(
              child: Column(
                children: [
                  userCart.isEmpty 
                    ? const Expanded(
                      child: Center(
                        child: Text("Cart is empty.."),
                     ),
                    )
                    : Expanded(
                       child: ListView.builder(
                       itemCount: userCart.length,
                       itemBuilder: (context, index) {
                       // get individual cart item
                       final cartItem = userCart[index];
              
                       // return cart tile UI
                       return CartTile(cartItem: cartItem);
                     },
                   ),
                 ),
                ],
              ),
            ),

            // payment button
            Buttons(
              onTap: () {
              Navigator.push(
                context, MaterialPageRoute(
                  builder: (context) => const PaymentPage(),
              ),
             );
            }, text: "Go to checkout"),

            const SizedBox(height: 15),
          ],
        ),
      );
    },
   );
  }
}