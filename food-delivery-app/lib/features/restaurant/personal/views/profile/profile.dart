import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/features/restaurant/personal/views/profile/widgets/profile_flexible_space_bar.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CSliverAppBar(
            expandedHeight: 250.0,
            flexibleSpace: ProfileFlexibleSpaceBar(),
            title: "My Profile",
            noLeading: true,
          ),

          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildMenuItems()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          _buildMenuItem(Icons.person_outline, 'Personal Info'),
          _buildMenuItem(Icons.settings_outlined, 'Settings'),
          _buildMenuItem(Icons.history, 'Withdrawal History'),
          _buildMenuItem(Icons.shopping_bag_outlined, 'Number of Orders', trailing: '29K'),
          _buildMenuItem(Icons.star_outline, 'User Reviews'),
          _buildMenuItem(Icons.logout, 'Log Out', color: Colors.red),
          _buildMenuItem(Icons.logout, 'Log Out', color: Colors.red),
          _buildMenuItem(Icons.logout, 'Log Out', color: Colors.red),
          _buildMenuItem(Icons.logout, 'Log Out', color: Colors.red),
          _buildMenuItem(Icons.logout, 'Log Out', color: Colors.red),
          _buildMenuItem(Icons.logout, 'Log Out', color: Colors.red),
          _buildMenuItem(Icons.logout, 'Log Out', color: Colors.red),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {String? trailing, Color? color}) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: color ?? Colors.grey),
        title: Text(title, style: TextStyle(color: color)),
        trailing: trailing != null
            ? Text(trailing, style: TextStyle(fontWeight: FontWeight.bold))
            : Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
