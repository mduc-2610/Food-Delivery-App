import 'package:flutter/material.dart';

class OrderCancelView extends StatefulWidget {
  @override
  _OrderCancelViewState createState() => _OrderCancelViewState();
}

class _OrderCancelViewState extends State<OrderCancelView> {
  String? _selectedReason;
  final TextEditingController _otherReasonController = TextEditingController();

  void _submit() {
    if (_selectedReason == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a reason')),
      );
      return;
    }

    if (_selectedReason == 'Other reasons' && _otherReasonController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please specify the other reason')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.cancel, size: 60, color: Colors.red),
              SizedBox(height: 16),
              Text('Your Order Canceled',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              Text(
                  "We're sorry to see your order go. We're always striving to improve, and we hope to serve you better next time!"),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Cancel Order'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildRadioOption('Change of mind'),
                  _buildRadioOption('Found better price elsewhere'),
                  _buildRadioOption('Delivery delay'),
                  _buildRadioOption('Incorrect item selected'),
                  _buildRadioOption('Duplicate order'),
                  _buildRadioOption('Unable to fulfill order'),
                  _buildRadioOption('Other reasons'),
                  if (_selectedReason == 'Other reasons')
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextField(
                        controller: _otherReasonController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Other reason',
                        ),
                      ),
                    ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Submit'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption(String reason) {
    return RadioListTile<String>(
      title: Text(reason),
      value: reason,
      groupValue: _selectedReason,
      onChanged: (String? value) {
        setState(() {
          _selectedReason = value;
        });
      },
    );
  }
}
