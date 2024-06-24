import 'dart:io';
import 'package:carentalapp/components/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:carentalapp/models/car.dart';
import 'package:carentalapp/components/buttons.dart';
import 'package:carentalapp/components/textfields.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth for current user

class AddCarPage extends StatefulWidget {
  @override
  _AddCarPageState createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  CarCategory? _category;
  CarFeatures? _features;
  CarFuel? _fuel;
  CarTrans? _trans;
  CarSeater? _seater;
  File? _imageFile;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<String?> _uploadImage() async {
    if (_imageFile == null) return null;

    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final storageRef =
          FirebaseStorage.instance.ref().child('car_images/$fileName');
      final uploadTask = storageRef.putFile(_imageFile!);
      final snapshot = await uploadTask.whenComplete(() => null);

      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> _addCar() async {
    if (!_formKey.currentState!.validate()) return;

    final imageUrl = await _uploadImage();

    if (imageUrl != null) {
      final car = Car(
        id: '',
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        imageUrl: imageUrl,
        price: double.parse(_priceController.text.trim()),
        category: _category!,
        features: _features!,
        fuel: _fuel!,
        trans: _trans!,
        seater: _seater!,
        ownerId: FirebaseAuth.instance.currentUser?.uid ??
            '', // Assign current user as owner
      );

      try {
        await FirebaseFirestore.instance.collection('cars').add(car.toMap());
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Success'),
            content: const Text('Car registration successful'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.of(context).pop(); // Go to homepage
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } catch (e) {
        print('Error adding car: $e');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(e.toString()),
          ),
        );
      }
    } else {
      print('Image upload failed.');
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Image upload failed!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register New Car'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // car name field
                      Textfields(
                        controller: _nameController,
                        hintText: 'Car Name',
                        obscureText: false,
                      ),

                      const SizedBox(height: 10),

                      // car description field
                      Textfields(
                        controller: _descriptionController,
                        hintText: 'Description',
                        obscureText: false,
                      ),

                      const SizedBox(height: 10),

                      // car price field
                      Textfields(
                        controller: _priceController,
                        hintText: 'Price per hour',
                        obscureText: false,
                      ),

                      const SizedBox(height: 10),

                      // Custom category dropdown
                      CustomDropdown<CarCategory>(
                        selectedValue: _category,
                        items: CarCategory.values,
                        hintText: 'Category',
                        onChanged: (CarCategory? newValue) {
                          setState(() {
                            _category = newValue;
                          });
                        },
                      ),

                      const SizedBox(height: 10),

                      // Custom features dropdown
                      CustomDropdown<CarFeatures>(
                        selectedValue: _features,
                        items: CarFeatures.values,
                        hintText: 'Features',
                        onChanged: (CarFeatures? newValue) {
                          setState(() {
                            _features = newValue;
                          });
                        },
                      ),

                      const SizedBox(height: 10),

                      // Custom fuel dropdown
                      CustomDropdown<CarFuel>(
                        selectedValue: _fuel,
                        items: CarFuel.values,
                        hintText: 'Fuel',
                        onChanged: (CarFuel? newValue) {
                          setState(() {
                            _fuel = newValue;
                          });
                        },
                      ),

                      const SizedBox(height: 10),

                      // Custom transmission dropdown
                      CustomDropdown<CarTrans>(
                        selectedValue: _trans,
                        items: CarTrans.values,
                        hintText: 'Transmission',
                        onChanged: (CarTrans? newValue) {
                          setState(() {
                            _trans = newValue;
                          });
                        },
                      ),

                      const SizedBox(height: 10),

                      // Custom seater dropdown
                      CustomDropdown<CarSeater>(
                        selectedValue: _seater,
                        items: CarSeater.values,
                        hintText: 'Seater',
                        onChanged: (CarSeater? newValue) {
                          setState(() {
                            _seater = newValue;
                          });
                        },
                      ),

                      const SizedBox(height: 20),

                      Center(
                        child: Column(
                          children: [
                            _imageFile != null
                                ? Image.file(
                                    _imageFile!,
                                    width: 350,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    height: 100,
                                    width: 150,
                                    color: Colors.grey.withOpacity(0.3),
                                    child: const Icon(Icons.image),
                                  ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: _pickImage,
                              child: const Text('Choose Car Image'),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      Buttons(
                        onTap: _addCar,
                        text: 'Register Car',
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
