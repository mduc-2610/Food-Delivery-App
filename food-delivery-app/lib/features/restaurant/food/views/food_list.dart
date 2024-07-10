import 'package:flutter/material.dart';

class FoodApp extends StatefulWidget {
  @override
  _FoodAppState createState() => _FoodAppState();
}

class _FoodAppState extends State<FoodApp> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Food'),
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          tabs: [
            Tab(text: 'My Food List'),
            Tab(text: 'Add New Items'),
            Tab(text: 'Food Details'),
            Tab(text: 'My Food List'),
            Tab(text: 'Add New Items'),
            Tab(text: 'Food Details'),

          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MyFoodListView(),
          AddNewItemsView(),
          FoodDetailsView(),
          MyFoodListView(),
          AddNewItemsView(),
          FoodDetailsView(),

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}

class MyFoodListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FoodListItem(name: 'Chicken Thai Biriyani', price: '\$60', rating: 4.9),
        FoodListItem(name: 'Chicken Bhuna', price: '\$30', rating: 4.9),
        FoodListItem(name: 'Mazalichiken Halim', price: '\$25', rating: 4.9),
      ],
    );
  }
}

class FoodListItem extends StatelessWidget {
  final String name;
  final String price;
  final double rating;

  FoodListItem({required this.name, required this.price, required this.rating});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        color: Colors.grey[300],
      ),
      title: Text(name),
      subtitle: Text('Breakfast'),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(price),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, size: 16, color: Colors.orange),
              Text('$rating'),
            ],
          ),
        ],
      ),
    );
  }
}

class AddNewItemsView extends StatefulWidget {
  @override
  _AddNewItemsViewState createState() => _AddNewItemsViewState();
}

class _AddNewItemsViewState extends State<AddNewItemsView> {
  String itemName = '';
  double price = 0.0;
  bool isPickup = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            child: ElevatedButton(
              child: Text('SAVE CHANGES'),
              onPressed: () {},
              style: ElevatedButton.styleFrom(primary: Colors.orange),
            ),
          ),
        ],
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