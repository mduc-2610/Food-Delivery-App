import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/main_wrapper.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class PromotionInformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: MainWrapper(
        bottomMargin: TSize.spaceBetweenSections,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Icon(Icons.local_shipping, size: 100, color: Colors.orange),
                  SizedBox(height: TSize.spaceBetweenItemsHorizontal),
                  Text(
                    'FREE SHIPPING',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            SizedBox(height: TSize.spaceBetweenSections),
            _buildPromotionDetail(context, 'Description', 'Enjoy free shipping on all orders throughout this month!'),
            _buildPromotionDetail(context, 'Duration', '01/05/2024 - 31/05/2024'),
            _buildPromotionDetail(context, 'Promo Code', 'FREESHIP'),
            _buildPromotionDetail(context, 'Applicable Scope', 'Applicable to all orders on our website or app.'),
            _buildPromotionDetail(context, 'Discount Amount', '100% off shipping (Free shipping).'),
            _buildPromotionDetail(context, 'Terms and Conditions', 'No minimum order requirement. Applicable for standard shipping within the country.'),
          ],
        ),
      ),
    );
  }

  Widget _buildPromotionDetail(BuildContext context, String title, String detail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title:',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          detail,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(height: TSize.spaceBetweenItemsVertical,),
      ],
    );
  }
}
