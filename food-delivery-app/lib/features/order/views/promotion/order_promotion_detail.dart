import 'package:flutter/material.dart';

class PromotionInformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Icon(Icons.local_shipping, size: 100, color: Colors.orange),
                SizedBox(height: 10),
                Text(
                  'FREE SHIPPING',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          _buildPromotionDetail('Description', 'Enjoy free shipping on all orders throughout this month!'),
          _buildPromotionDetail('Duration', '01/05/2024 - 31/05/2024'),
          _buildPromotionDetail('Promo Code', 'FREESHIP'),
          _buildPromotionDetail('Applicable Scope', 'Applicable to all orders on our website or app.'),
          _buildPromotionDetail('Discount Amount', '100% off shipping (Free shipping).'),
          _buildPromotionDetail('Terms and Conditions', 'No minimum order requirement. Applicable for standard shipping within the country.'),
        ],
      ),
    );
  }

  Widget _buildPromotionDetail(String title, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(detail),
          ),
        ],
      ),
    );
  }
}
