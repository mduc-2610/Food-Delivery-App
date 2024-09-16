import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/features/deliverer/registration/views/first/registration_first_step.dart';
import 'package:get/get.dart';

class RegistrationStepView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  _buildRegistrationStep(
                    step: 1,
                    title: 'Tạo hồ sơ',
                    subtitle: '- Thời gian thực hiện: khoảng 60 phút\n'
                        '- Giấy tờ cần chuẩn bị:CCCD, Giấy phép lái xe,\n'
                        '  Chứng nhận đăng ký xe mô tô, gắn máy.',
                    isActive: true,
                  ),
                  SizedBox(height: 16),
                  _buildRegistrationStep(
                    step: 2,
                    title: 'Ký hợp đồng',
                  ),
                  SizedBox(height: 16),
                  _buildRegistrationStep(
                    step: 3,
                    title: 'Mua đồng phục',
                  ),
                  SizedBox(height: 16),
                  _buildRegistrationStep(
                    step: 4,
                    title: 'Tạo ảnh đại diện',
                  ),
                  SizedBox(height: 16),
                  _buildRegistrationStep(
                    step: 5,
                    title: 'Tham gia Đào tạo hợp tác Tài xế',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Đăng ký',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'Hỗ trợ',
            style: TextStyle(fontSize: 16, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget _buildRegistrationStep({
    required int step,
    required String title,
    String? subtitle,
    bool isActive = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? Colors.red : Colors.grey,
              ),
              child: Center(
                child: Text(
                  '$step',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        if (subtitle != null)
          Padding(
            padding: EdgeInsets.only(left: 32, top: 8),
            child: Text(
              subtitle,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ),
        if (isActive)
          Padding(
            padding: EdgeInsets.only(left: 32, top: 16),
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => RegistrationFirstStepView());
              },
              child: Text('Gửi hồ sơ'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 40),
              ),
            ),
          ),
      ],
    );
  }
}