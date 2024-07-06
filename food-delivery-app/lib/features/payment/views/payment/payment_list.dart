import 'package:flutter/material.dart';

class OrderPaymentListView extends StatefulWidget {
  @override
  _OrderPaymentListViewState createState() => _OrderPaymentListViewState();
}

class _OrderPaymentListViewState extends State<OrderPaymentListView> {
  String _selectedMethod = 'Cash';

  final List<Map<String, dynamic>> paymentMethods = [
    {'icon': Icons.money, 'name': 'Cash'},
    {'icon': Icons.account_balance_wallet, 'name': 'PayPal'},
    {'icon': Icons.account_balance_wallet, 'name': 'Google Pay'},
    {'icon': Icons.account_balance_wallet, 'name': 'Apple Pay'},
    {'icon': Icons.credit_card, 'name': '**** **** **** 0895'},
    {'icon': Icons.credit_card, 'name': '**** **** **** 2259'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Methods'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: paymentMethods.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(paymentMethods[index]['icon']),
                    title: Text(paymentMethods[index]['name']),
                    trailing: Radio<String>(
                      value: paymentMethods[index]['name'],
                      groupValue: _selectedMethod,
                      onChanged: (value) {
                        setState(() {
                          _selectedMethod = value!;
                        });
                      },
                    ),
                    onTap: () {
                      setState(() {
                        _selectedMethod = paymentMethods[index]['name'];
                      });
                    },
                  );
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add New Card'),
              onTap: () {
                // Handle add new card action
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle apply action
              },
              child: Text('Apply'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
