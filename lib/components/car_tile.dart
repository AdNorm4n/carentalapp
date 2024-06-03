import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/car.dart';

class CarTile extends StatelessWidget {
  final Car car;
  final void Function()? onTap;

  const CarTile({
    super.key, 
    required this.car, 
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(car.name),
                      Text(
                        '\RM' + car.price.toStringAsFixed(2) + '/hour',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        car.description,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 15),

                // Display car image from URL
                car.imageUrl.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: car.imageUrl,
                          placeholder: (context, url) => Container(
                            height: 100,
                            width: 100,
                            color: Theme.of(context).colorScheme.background,
                            child: const Center(child: CircularProgressIndicator()),
                          ),
                          errorWidget: (context, url, error) => Container(
                            height: 100,
                            width: 100,
                            color: Theme.of(context).colorScheme.background,
                            child: const Icon(Icons.image_not_supported),
                          ),
                          height: 100,
                        ),
                      )
                    : Container(
                        height: 100,
                        width: 100,
                        color: Theme.of(context).colorScheme.background,
                        child: const Icon(Icons.image_not_supported),
                      ),
              ],
            ),
          ),
        ),
        Divider(
          color: Theme.of(context).colorScheme.primary,
          endIndent: 25,
          indent: 25,
        ),
      ],
    );
  }
}
