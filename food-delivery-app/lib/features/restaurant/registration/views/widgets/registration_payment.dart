import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_dropdown_field.dart'; // Assuming you have a dropdown widget

class RegistrationPayment extends StatefulWidget {
  @override
  _RegistrationPaymentState createState() => _RegistrationPaymentState();
}

class _RegistrationPaymentState extends State<RegistrationPayment> {
  // Controllers for the text fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();

  String? selectedBank = 'NH Ngoại thương Viet Nam (Vietcombank)';
  String? selectedCity;
  String? selectedBranch;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            RegistrationTextField(
              label: 'Email truy cập ví NowMerchant Wallet',
              onChanged: (value) {},
              hintText: 'Nhập email',
              maxLines: 1,
            ),
            SizedBox(height: 16),
            RegistrationTextField(
              label: 'SĐT truy cập ví NowMerchant Wallet',
              onChanged: (value) {},
              hintText: 'Nhập số điện thoại',
              maxLines: 1,
            ),
            SizedBox(height: 16),
            RegistrationTextField(
              label: 'Số CMND',
              onChanged: (value) {},
              hintText: 'Nhập số CMND',
              maxLines: 1,
            ),
            SizedBox(height: 16),
            RegistrationTextField(
              label: 'Tên chủ tài khoản ngân hàng',
              onChanged: (value) {},
              hintText: 'Nhập tên tài khoản',
              maxLines: 1,
            ),
            SizedBox(height: 16),
            RegistrationTextField(
              label: 'Số tài khoản ngân hàng',
              onChanged: (value) {},
              hintText: 'Nhập số tài khoản',
              maxLines: 1,
            ),
            SizedBox(height: 16),
            RegistrationDropdownField(
              label: 'Tên ngân hàng',
              items: [
                'NH Ngoại thương Viet Nam (Vietcombank)',
                'NH Công thương Viet Nam (Vietinbank)',
                'NH Đầu tư và Phát triển Viet Nam (BIDV)',
              ],
              onChanged: (String? value) {
                setState(() {
                  selectedBank = value;
                });
              },
            ),
            SizedBox(height: 16),
            RegistrationDropdownField(
              label: 'Tỉnh/Thành phố của chi nhánh',
              items: [
                'Hà Nội',
                'TP. Hồ Chí Minh',
                'Đà Nẵng',
                'Cần Thơ',
              ],
              onChanged: (String? value) {
                setState(() {
                  selectedCity = value;
                });
              },
            ),
            SizedBox(height: 16),
            RegistrationDropdownField(
              label: 'Chi nhánh ngân hàng',
              items: [
                'Chi nhánh A',
                'Chi nhánh B',
                'Chi nhánh C',
              ],
              onChanged: (String? value) {
                setState(() {
                  selectedBranch = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
