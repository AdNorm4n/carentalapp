// car item
class Car {
  final String name;           // Myvi 
  final String description;    // Myvi condition 
  final String imagePath;      // lib/images/myvi.png
  final double price;          // 10.50
  final CarCategory category;  // economy
  final CarFeatures features;  // hatchback
  final CarFuel fuel;          // petrol
  final CarTrans trans;        // automatic
  final CarSeater seater;      // five

  Car({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.category,
    required this.features,
    required this.fuel,
    required this.trans,
    required this.seater,
  });
}

// car categories 
enum CarCategory {
  economy,
  sports,
  luxury,
}

// car categories 
enum CarFeatures {
  hatchback,
  coupe,
  sedan,
  suv,
  mpv,
}

// car fuel 
enum CarFuel {
  petrol,
  diesel,
  hybrid,
  electriv,
}

// car trans 
enum CarTrans {
  manual,
  automatic,
}

// car seater 
enum CarSeater {
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
}
