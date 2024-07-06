import 'package:flutter/material.dart';

import 'package:food_delivery_app/utils/constants/image_strings.dart';

class DeliveryMealRatingView extends StatefulWidget {
  @override
  _DeliveryMealRatingViewState createState() => _DeliveryMealRatingViewState();
}

class _DeliveryMealRatingViewState extends State<DeliveryMealRatingView> {
  final List<Meal> meals = [
    Meal('Chicken Burger', TImage.hcBurger1),
    Meal('Ramen Noodles', TImage.hcBurger1),
    Meal('Cherry Tomato Salad', TImage.hcBurger1),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate Your Meal'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: meals.length,
          itemBuilder: (context, index) {
            return MealRatingCard(meal: meals[index]);
          },
        ),
      ),
    );
  }
}

class Meal {
  final String name;
  final String imagePath;
  int rating;
  String review;

  Meal(this.name, this.imagePath, {this.rating = 0, this.review = ''});
}

class MealRatingCard extends StatefulWidget {
  final Meal meal;

  MealRatingCard({required this.meal});

  @override
  _MealRatingCardState createState() => _MealRatingCardState();
}

class _MealRatingCardState extends State<MealRatingCard> {
  void _submitRating() {
    print("SUBMIT");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.favorite, size: 60, color: Colors.red),
              SizedBox(height: 16),
              Text(
                'Thank you!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text('Your feedback has been submitted.'),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text('Ok'),
              ),
            ],
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(widget.meal.imagePath, width: 50, height: 50),
                SizedBox(width: 10),
                Text(widget.meal.name),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < widget.meal.rating
                        ? Icons.star
                        : Icons.star_border,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.meal.rating = index + 1;
                    });
                  },
                );
              }),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Type your review ...',
              ),
              onChanged: (value) {
                widget.meal.review = value;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _submitRating,
                  child: Text('Skip'),
                ),
                ElevatedButton(
                  onPressed: _submitRating,
                  child: Text('Submit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
