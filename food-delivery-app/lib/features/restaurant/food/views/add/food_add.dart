import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';


class FoodAddView extends StatefulWidget {
  @override
  _FoodAddViewState createState() => _FoodAddViewState();
}

class _FoodAddViewState extends State<FoodAddView> {
  String itemName = '';
  double price = 0.0;
  bool isPickup = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        title: "Add New Items",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ITEM NAME', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(hintText: 'Mazalichiken Halim'),
              onChanged: (value) => setState(() => itemName = value),
            ),
            SizedBox(height: 20),
            Text('UPLOAD PHOTO/VIDEO', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey[300],
                  child: Icon(Icons.add_a_photo, color: Colors.grey[600]),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('PRICE', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(hintText: '50'),
              keyboardType: TextInputType.number,
              onChanged: (value) => setState(() => price = double.tryParse(value) ?? 0),
            ),
            Row(
              children: [
                Checkbox(
                  value: isPickup,
                  onChanged: (value) => setState(() => isPickup = value!),
                ),
                Text('Pick up'),
                Checkbox(
                  value: !isPickup,
                  onChanged: (value) => setState(() => isPickup = !value!),
                ),
                Text('Delivery'),
              ],
            ),
            SizedBox(height: 20),
            Text('INGREDIENTS', style: TextStyle(fontWeight: FontWeight.bold)),
            IngredientSection(title: 'Basic'),
            IngredientSection(title: 'Fruit'),
            SizedBox(height: 20),
            Text('DETAILS', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Lorem ipsum dolor sit amet, consectetur adipis cing elit. Bibendum in vel, mattis et amet dui mauris turpis.',
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: MainButton(
                text: 'SAVE CHANGES',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IngredientSection extends StatelessWidget {
  final String title;

  IngredientSection({required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Row(
          children: [
            IngredientIcon(icon: Icons.fastfood, label: 'Salt'),
            IngredientIcon(icon: Icons.fastfood, label: 'Chicken'),
            IngredientIcon(icon: Icons.soup_kitchen, label: 'Onion'),
            IngredientIcon(icon: Icons.food_bank, label: 'Garlic'),
            IngredientIcon(icon: Icons.spa, label: 'Peppers'),
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            child: Text('See All'),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

class IngredientIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  IngredientIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.orange),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}

class FoodDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            color: Colors.grey[300],
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Breakfast', style: TextStyle(color: Colors.grey)),
                    Text('Delivery', style: TextStyle(color: Colors.grey)),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Chicken Thai Biriyani', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    Text('\$60', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 16),
                    Text('4.9 (10 Reviews)', style: TextStyle(color: Colors.grey)),
                  ],
                ),
                SizedBox(height: 20),
                Text('INGREDIENTS', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    IngredientIcon(icon: Icons.fastfood, label: 'Salt'),
                    IngredientIcon(icon: Icons.fastfood, label: 'Chicken'),
                    IngredientIcon(icon: Icons.soup_kitchen, label: 'Onion'),
                    IngredientIcon(icon: Icons.food_bank, label: 'Garlic'),
                    IngredientIcon(icon: Icons.spa, label: 'Peppers'),
                    IngredientIcon(icon: Icons.grass, label: 'Ginger'),
                    IngredientIcon(icon: Icons.eco, label: 'Broccoli'),
                    IngredientIcon(icon: Icons.satellite_alt, label: 'Orange'),
                    IngredientIcon(icon: Icons.nature, label: 'Walnut'),
                  ],
                ),
                SizedBox(height: 20),
                Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text('Lorem ipsum dolor sit amet, consectetur adipis cing elit. Bibendum in vel, mattis et amet dui mauris turpis.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}