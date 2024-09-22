import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FoodAddView extends StatefulWidget {
  @override
  _FoodAddViewState createState() => _FoodAddViewState();
}

class _FoodAddViewState extends State<FoodAddView> {
  final _formKey = GlobalKey<FormState>();
  String dishName = '';
  String description = '';
  double originalPrice = 0.0;
  double discountPrice = 0.0;
  String? category;
  String? restaurant;
  File? imageFile;

  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Dish')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dish Name', style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                decoration: InputDecoration(hintText: 'Enter dish name'),
                onChanged: (value) => dishName = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a dish name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(hintText: 'Enter a description'),
                onChanged: (value) => description = value,
              ),
              SizedBox(height: 20),

              Text('Original Price', style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Enter original price'),
                onChanged: (value) => originalPrice = double.tryParse(value) ?? 0,
              ),
              SizedBox(height: 20),

              Text('Discount Price', style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Enter discount price (optional)'),
                onChanged: (value) => discountPrice = double.tryParse(value) ?? 0,
              ),
              SizedBox(height: 20),

              // Category Dropdown
              Text('Category', style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(hintText: 'Select category'),
                value: category,
                items: ['Starter', 'Main Course', 'Dessert'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    category = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Restaurant Dropdown
              Text('Restaurant', style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(hintText: 'Select restaurant'),
                value: restaurant,
                items: ['Restaurant A', 'Restaurant B', 'Restaurant C'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    restaurant = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a restaurant';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Image Picker
              Text('Upload Image', style: TextStyle(fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: imageFile != null
                      ? Image.file(imageFile!, fit: BoxFit.cover)
                      : Icon(Icons.add_a_photo, color: Colors.grey[600]),
                ),
              ),
              SizedBox(height: 20),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: MainButton(
                  text: 'Save Dish',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Submit form data
                      print('Dish Name: $dishName');
                      print('Description: $description');
                      print('Original Price: $originalPrice');
                      print('Discount Price: $discountPrice');
                      print('Category: $category');
                      print('Restaurant: $restaurant');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
