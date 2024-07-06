import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/order/views/promotion/order_promotion_detail.dart';

class OrderPromotionView extends StatefulWidget {
  @override
  _OrderPromotionViewState createState() => _OrderPromotionViewState();
}

class _OrderPromotionViewState extends State<OrderPromotionView> {
  bool freeShippingSelected = false;
  bool discount20OffSelected = false;
  bool order20OffSelected = false;
  bool order10OffSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Promotions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Promo Code',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Apply'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  Text('Shipping Offers', style: TextStyle(fontWeight: FontWeight.bold)),
                  InkWell(
                    onTap: () {
                      print("TAP");
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return PromotionInformationPage();
                        },
                      );
                    },
                    child: _buildPromotionItem('FREE SHIPPING', freeShippingSelected, (value) {
                      setState(() {
                        freeShippingSelected = value!;
                      });
                    }),
                  ),
                  _buildPromotionItem('20% OFF', discount20OffSelected, (value) {
                    setState(() {
                      discount20OffSelected = value!;
                    });
                  }),
                  SizedBox(height: 20),
                  Text('Order Offers', style: TextStyle(fontWeight: FontWeight.bold)),
                  _buildPromotionItem('20% OFF', order20OffSelected, (value) {
                    setState(() {
                      order20OffSelected = value!;
                    });
                  }),
                  _buildPromotionItem('10% OFF', order10OffSelected, (value) {
                    setState(() {
                      order10OffSelected = value!;
                    });
                  }),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Get More Promotions'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      onPrimary: Theme.of(context).primaryColor,
                      elevation: 0,
                      textStyle: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Apply'),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                onPrimary: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromotionItem(String title, bool value, Function(bool?) onChanged) {
    return CheckboxListTile(
      title: InkWell(
        onTap: () {
          print("TAP");
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return PromotionInformationPage();
            },
          );
        },
        child: Text(title)
      ),
      value: value,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.trailing,
    );
  }
}

