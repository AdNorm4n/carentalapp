import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carentalapp/components/buttons.dart';
import 'package:carentalapp/components/cart_tile.dart';
import 'package:carentalapp/models/go_rent.dart';
import 'package:carentalapp/pages/booking_detail_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GoRent>(
      builder: (context, gorent, child) {
        final userCart = gorent.cart;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Rental Cart"),
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                          "Are you sure you want to clear the cart?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
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
              Expanded(
                child: userCart.isEmpty
                    ? Center(
                        child: const Text("Cart is empty.."),
                      )
                    : ListView.builder(
                        itemCount: userCart.length,
                        itemBuilder: (context, index) {
                          final cartItem = userCart[index];
                          return CartTile(cartItem: cartItem);
                        },
                      ),
              ),
              Buttons(
                onTap: () {
                  if (userCart.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Cannot Proceed"),
                        content: const Text(
                            "Your cart is empty. Please add car(s) to proceed."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BookingDetailPage(),
                      ),
                    );
                  }
                },
                text: "Proceed",
              ),
              const SizedBox(height: 15),
            ],
          ),
        );
      },
    );
  }
}
