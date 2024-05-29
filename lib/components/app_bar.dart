// SPRINT 1

import 'package:carentalapp/pages/cart_page.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  final Widget child;
  final Widget title;

  const HomeAppBar({
    super.key, 
    required this.child, 
    required this.title,
   });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 335,
      collapsedHeight: 100,
      floating: false,
      pinned: true,
      actions:[
        // cart button
        IconButton(
          onPressed: () {
            // go to the cart page
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => const CartPage(),
            ),
           );
          }, 
          icon: const Icon(Icons.directions_car),
        ),
      ],
      backgroundColor: Theme.of(context).colorScheme.background,
      foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text("Available Cars"),
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.only(bottom:50.0),
          child: child,
        ), 
        title: title,
        centerTitle: true,
        titlePadding: const EdgeInsets.only(left:0, right:0, top:0),
        expandedTitleScale: 1,
      ),
    );
  }
}