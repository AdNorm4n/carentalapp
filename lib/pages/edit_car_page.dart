import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:carentalapp/models/car.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditCarPage extends StatefulWidget {
  final String carId;

  const EditCarPage({Key? key, required this.carId}) : super(key: key);

  @override
  _EditCarPageState createState() => _EditCarPageState();
}

class _EditCarPageState extends State<EditCarPage> {
  Car? car;
  bool isLoading = true;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    fetchCar();
  }

  Future<void> fetchCar() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('cars')
          .doc(widget.carId)
          .get();
      setState(() {
        car = Car.fromFirestore(doc);
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching car: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> editField(String field, dynamic newValue) async {
    try {
      await FirebaseFirestore.instance
          .collection('cars')
          .doc(widget.carId)
          .update({field: newValue});
      await fetchCar(); // Refresh car data
    } catch (e) {
      print("Error updating field: $e");
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      await _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    try {
      final storageRef =
          FirebaseStorage.instance.ref().child('car_images/${widget.carId}');
      await storageRef.putFile(_imageFile!);
      final imageUrl = await storageRef.getDownloadURL();
      await editField('imageUrl', imageUrl);
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  void _showEditDialog(String field, String currentValue) {
    TextEditingController controller =
        TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $field'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter new $field'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                String newValue = controller.text;
                if (newValue.isNotEmpty) {
                  if (field == 'price') {
                    await editField(field, double.parse(newValue));
                  } else {
                    await editField(field, newValue);
                  }
                }
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Edit Car Details"),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  // Centralized Image Display
                  Center(
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: _imageFile == null
                          ? Image.network(
                              car!.imageUrl,
                              width: 400,
                            )
                          : Image.file(
                              _imageFile!,
                              width: 400,
                            ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  // Car details
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Car Details',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                  // Car name
                  _buildTextBox('Name', car!.name,
                      () => _showEditDialog('name', car!.name)),
                  // Car description
                  _buildTextBox('Description', car!.description,
                      () => _showEditDialog('description', car!.description)),
                  // Car price
                  _buildTextBox(
                      'Price/hour',
                      'RM${car!.price.toStringAsFixed(2)}',
                      () => _showEditDialog('price', car!.price.toString())),
                  // Car category
                  _buildEnumTextBox(
                      'Category', car!.category.toString().split('.').last),
                  // Car features
                  _buildEnumTextBox(
                      'Features', car!.features.toString().split('.').last),
                  // Car fuel
                  _buildEnumTextBox(
                      'Fuel', car!.fuel.toString().split('.').last),
                  // Car transmission
                  _buildEnumTextBox(
                      'Trans', car!.trans.toString().split('.').last),
                  // Car seater
                  _buildEnumTextBox(
                      'Seater', car!.seater.toString().split('.').last),
                  const SizedBox(height: 25),
                ],
              ),
            ),
    );
  }

  Widget _buildTextBox(String title, String text, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnumTextBox(String title, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
