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
                RegistrationSkeletonField(label: 'Họ và tên đệm'),
                RegistrationSkeletonField(label: 'Tên'),
                RegistrationSkeletonField(label: 'Giới tính'),
                RegistrationSkeletonField(label: 'Ngày sinh'),
                RegistrationSkeletonField(label: 'Quê quán'),
                RegistrationSkeletonField(label: 'Tỉnh/Thành phố thường trú (trên CCCD)'),
                RegistrationSkeletonField(label: 'Quận/Huyện thường trú (trên CCCD)'),
                RegistrationSkeletonField(label: 'Phường/Xã thường trú (trên CCCD)'),
                RegistrationSkeletonField(label: 'Địa chỉ thường trú (trên CCCD)'),
                RegistrationSkeletonField(label: 'Số Căn cước công dân (CCCD)'),
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

}

class RegistrationSkeletonField extends StatelessWidget {
  const RegistrationSkeletonField({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
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