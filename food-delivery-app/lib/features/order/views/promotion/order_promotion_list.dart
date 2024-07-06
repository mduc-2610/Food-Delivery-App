import 'package:flutter/material.dart';

class OrderPromotionList extends StatelessWidget {
  final List<Map<String, dynamic>> promotionActions = [
    {'icon': Icons.share, 'title': 'Share App'},
    {'icon': Icons.person_add, 'title': 'Invite Friends'},
    {'icon': Icons.shopping_cart, 'title': 'Complete Purchases'},
    {'icon': Icons.ondemand_video, 'title': 'Watch Ads'},
    {'icon': Icons.event, 'title': 'Participate in Events'},
    {'icon': Icons.account_circle, 'title': 'Complete Profile'},
    {'icon': Icons.follow_the_signs, 'title': 'Follow Social Media'},
    {'icon': Icons.question_answer, 'title': 'Take Surveys'},
    {'icon': Icons.emoji_events, 'title': 'Achieve Levels'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get More Promotions'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: promotionActions.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(promotionActions[index]['icon'], color: Colors.orange),
            title: Text(promotionActions[index]['title']),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // Handle the tap
            },
          );
        },
      ),
    );
  }
}
