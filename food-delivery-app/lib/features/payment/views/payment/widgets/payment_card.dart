import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/main_button.dart';
import 'package:food_delivery_app/common/widgets/main_wrapper.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:intl/intl.dart';

class PaymentCard extends StatefulWidget {
  @override
  _PaymentCardState createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _cardholderNameController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: TDeviceUtil.getScreenHeight() * 0.7,
      child: Scaffold(
        body: MainWrapper(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: TSize.spaceBetweenSections,),

              Text(
                "Add New Card",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: TSize.spaceBetweenSections,),

              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: _cardNumberController,
                      decoration: InputDecoration(
                        labelText: 'Card Number',
                        border: OutlineInputBorder(),
                        counterText: "",
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 19,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter card number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: TSize.spaceBetweenItemsVertical),
                    TextFormField(
                      controller: _cardholderNameController,
                      decoration: InputDecoration(
                        labelText: 'Cardholder Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter cardholder name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: TSize.spaceBetweenItemsVertical),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: _expiryDateController,
                            decoration: InputDecoration(
                              labelText: 'Expiry Date',
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );
                              if (pickedDate != null) {
                                String formattedDate = DateFormat('MM/yy').format(pickedDate);
                                setState(() {
                                  _expiryDateController.text = formattedDate;
                                });
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter expiry date';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: TSize.spaceBetweenItemsVertical),
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) {
                              if ((_formKey.currentState?.validate() ?? false)) {
                                setState(() {});
                              }
                            },
                            controller: _cvvController,
                            decoration: InputDecoration(
                              labelText: 'CVV',
                              border: OutlineInputBorder(),
                              counterText: ""
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 3,
                            validator: (value) {
                              if (value == null || value.isEmpty || hasError) {
                                return 'Please enter CVV';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: TSize.spaceBetweenItemsVertical),

                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: MainWrapper(
          bottomMargin: TSize.spaceBetweenSections,
          child: Container(
            height: TDeviceUtil.getBottomNavigationBarHeight(),
            child: MainButton(
              onPressed: () {
                if (_formKey.currentState?.validate() == true) {
                  // Process the card data
                }
              },
              text: "Save",
            ),
          ),
        ),
      ),
    );
  }
}