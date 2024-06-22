import 'package:cloud_firestore/cloud_firestore.dart';

enum CarCategory { economy, sports, luxury }

enum CarFeatures { hatchback, suv, coupe, mpv }

enum CarFuel { petrol, diesel, electric }

enum CarTrans { automatic, manual }

enum CarSeater { two, four, five, seven }

class Car {
  String id;
  String name;
  String description;
  String imageUrl;
  double price;
  CarCategory category;
  CarFeatures features;
  CarFuel fuel;
  CarTrans trans;
  CarSeater seater;
  String ownerId; // Owner ID

  Car({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.category,
    required this.features,
    required this.fuel,
    required this.trans,
    required this.seater,
    required this.ownerId, // Initialize owner ID in constructor
  });

  factory Car.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Car(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      category: CarCategory.values[data['category'] ?? 0],
      features: CarFeatures.values[data['features'] ?? 0],
      fuel: CarFuel.values[data['fuel'] ?? 0],
      trans: CarTrans.values[data['trans'] ?? 0],
      seater: CarSeater.values[data['seater'] ?? 0],
      ownerId: data['ownerId'] ?? '', // Assign ownerId from Firestore data
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'category': category.index,
      'features': features.index,
      'fuel': fuel.index,
      'trans': trans.index,
      'seater': seater.index,
      'ownerId': ownerId, // Include ownerId in the map
    };
  }
}
