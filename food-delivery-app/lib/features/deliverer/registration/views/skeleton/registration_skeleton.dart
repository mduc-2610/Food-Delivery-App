import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_bottom_navigation_bar.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class RegistrationSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildSkeletonField('Họ và tên đệm'),
                _buildSkeletonField('Tên'),
                _buildSkeletonField('Giới tính'),
                _buildSkeletonField('Ngày sinh'),
                _buildSkeletonField('Quê quán'),
                _buildSkeletonField('Tỉnh/Thành phố thường trú (trên CCCD)'),
                _buildSkeletonField('Quận/Huyện thường trú (trên CCCD)'),
                _buildSkeletonField('Phường/Xã thường trú (trên CCCD)'),
                _buildSkeletonField('Địa chỉ thường trú (trên CCCD)'),
                _buildSkeletonField('Số Căn cước công dân (CCCD)'),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: RegistrationBottomNavigationBar(
        onSave: () {},
        onContinue: () {},
      ),
    );
  }

  Widget _buildSkeletonField(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BoxSkeleton(
            height: 20,
            width: 150,
            // borderRadius: TSize.borderRadiusSm,
          ),
          const SizedBox(height: 8),
          BoxSkeleton(
            height: 48,
            width: double.infinity,
            // borderRadius: TSize.borderRadiusMd,
          ),
        ],
      ),
    );
  }
}