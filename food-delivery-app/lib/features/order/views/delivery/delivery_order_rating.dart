import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/order/views/delivery/delivery_driver_rating.dart';

class DeliveryOrderRatingView extends StatefulWidget {
  @override
  _DeliveryOrderRatingViewState createState() => _DeliveryOrderRatingViewState();
}

class _DeliveryOrderRatingViewState extends State<DeliveryOrderRatingView> {
  int _rating = 0;

  void _submitRating() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DeliveryDriverRatingView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Rating'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'Rate your Experience',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Icon(Icons.diamond, size: 60, color: Colors.blue),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < _rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
                onPressed: () {
                  setState(() {
                    _rating = index + 1;
                  });
                },
              );
            }),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Type your review...',
            ),
          ),
          Spacer(),
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
          SizedBox(height: 20),
        ],
      ),
    );
  }
}