import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';

class RegistrationResidencyInfo extends StatefulWidget {
  @override
  _RegistrationResidencyInfoState createState() => _RegistrationResidencyInfoState();
}

class _RegistrationResidencyInfoState extends State<RegistrationResidencyInfo> {
  bool _isSameAsCCCD = true;
  bool _hasTaxNumber = false;

  final TextEditingController _cityController = TextEditingController(text: 'Hà Nội');
  final TextEditingController _districtController = TextEditingController(text: 'Quận Hai Bà Trưng');
  final TextEditingController _wardController = TextEditingController(text: 'Phường Bách Khoa');
  final TextEditingController _addressController = TextEditingController(text: 'Trần Đại Nghĩa');
  final TextEditingController _taxNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                _buildAddressSection(),
                SizedBox(height: 20),
                _buildTaxNumberSection(),
                RegistrationTextField(label: "Email", onChanged: (x) {}),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Địa chỉ tạm trú',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Giống địa chỉ trên CCCD',
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
              CupertinoSwitch(
                value: _isSameAsCCCD,
                onChanged: (bool value) {
                  setState(() {
                    _isSameAsCCCD = value;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 16),
          if (!_isSameAsCCCD) ...[
            _buildTextField('Tỉnh/Thành phố', _cityController),
            _buildTextField('Quận/Huyện', _districtController),
            _buildTextField('Phường/Xã', _wardController),
            _buildTextField('Địa chỉ', _addressController),
          ]
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {int? maxLength}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.red, fontSize: 14),
          ),
          SizedBox(height: 4),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nhập $label',
            ),
            maxLength: maxLength,
          ),
        ],
      ),
    );
  }

  Widget _buildTaxNumberSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFormField2('Bạn có mã số thuế TNCN hay không?', 'Có', isToggle: true),
        if (_hasTaxNumber) _buildTextField('Mã số thuế', _taxNumberController),
      ],
    );
  }

  Widget _buildFormField2(String label, String value, {bool isToggle = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.red, fontSize: 14),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              CupertinoSwitch(
                value: _hasTaxNumber,
                onChanged: (bool newValue) {
                  setState(() {
                    _hasTaxNumber = newValue;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, String value, {bool isDropdown = false, bool isDate = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.red, fontSize: 14),
          ),
          SizedBox(height: 4),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                if (isDropdown || isDate)
                  Icon(
                    isDate ? Icons.calendar_today : Icons.arrow_drop_down,
                    color: Colors.grey,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
