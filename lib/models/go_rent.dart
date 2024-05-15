import 'package:flutter/material.dart';
import 'car.dart';

class GoRent extends ChangeNotifier{
  // list of available cars
  final List<Car> _menu = [
    // economy
    Car(
      name: "Perodua Myvi", 
      description: "Introducing the Myvi: your compact, reliable ride for any journey. Rent now for a stress-free driving experience!", 
      imagePath: "lib/images/economy/myvi.png", 
      price: 10.99, 
      category: CarCategory.economy, 
      features: CarFeatures.hatchback,
      fuel: CarFuel.petrol,
      trans: CarTrans.automatic,
      seater: CarSeater.five,
    ),
    Car(
      name: "Proton X50", 
      description: "Introducing the X50: your adaptable, reliable ride for any adventure. Rent now for a worry-free driving experience!", 
      imagePath: "lib/images/economy/x50.png", 
      price: 15.00, 
      category: CarCategory.economy, 
      features: CarFeatures.suv,
      fuel: CarFuel.petrol,
      trans: CarTrans.automatic,
      seater: CarSeater.five
    ),


    // sports
    Car(
      name: "Honda HRV", 
      description: "Experience the HRV: your versatile, dependable companion for every trip. Rent now for a seamless driving adventure!", 
      imagePath: "lib/images/sports/hrv.png", 
      price: 20.00, 
      category: CarCategory.sports, 
      features: CarFeatures.suv,
      fuel: CarFuel.petrol,
      trans: CarTrans.automatic,
      seater: CarSeater.five,
    ),
    Car(
      name: "Ford Mustang", 
      description: "Rev up with the Mustang: your dynamic, powerful choice for unforgettable drives. Rent now for an exhilarating journey on the road!", 
      imagePath: "lib/images/sports/mustang.png", 
      price: 40.00, 
      category: CarCategory.sports, 
      features: CarFeatures.coupe,
      fuel: CarFuel.petrol,
      trans: CarTrans.automatic,
      seater: CarSeater.four,
    ),
  

    // luxury
    Car(
      name: "Toyota Alphard", 
      description: "Embark on luxury with the Alphard: your spacious, opulent sanctuary on wheels. Rent now for a lavish driving escapade!", 
      imagePath: "lib/images/luxury/alphard.png", 
      price: 50.00, 
      category: CarCategory.luxury, 
      features: CarFeatures.mpv,
      fuel: CarFuel.petrol,
      trans: CarTrans.automatic,
      seater: CarSeater.seven,
    ),
    Car(
      name: "BMW M2", 
      description: "Unleash the M2: your thrilling, high-performance ride for adrenaline-packed journeys. Rent now for an unmatched driving thrill!", 
      imagePath: "lib/images/luxury/bmw.png", 
      price: 80.00, 
      category: CarCategory.luxury, 
      features: CarFeatures.coupe,
      fuel: CarFuel.petrol,
      trans: CarTrans.manual,
      seater: CarSeater.four,
    ),
    Car(
      name: "Mercedes Benz A200", 
      description: "Step into luxury with the A200: your sophisticated, refined partner for every mile. Rent now for an elegant driving experience!", 
      imagePath: "lib/images/luxury/mercedes.png", 
      price: 40.00, 
      category: CarCategory.luxury, 
      features: CarFeatures.hatchback,
      fuel: CarFuel.petrol,
      trans: CarTrans.automatic,
      seater: CarSeater.five,
    ),

  ]; 

  /*

  GETTERS

  */

  List<Car> get menu => _menu;

  /*
  
  OPERATIONS

  */

  // add to rental cart 

  // remove from rental cart

  // get total price of rental cart

  // get total number of item in rental cart

  // clear rental cart

  /*

  HELPERS

  */

  // generate a receipt 

  // format double value into money
}