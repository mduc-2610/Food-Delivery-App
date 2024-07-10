import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/restaurant/home/views/common/widgets/revenue_chart.dart';
import 'package:food_delivery_app/features/restaurant/home/views/revenue_detail/revenue_detail.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';


class RevenueStatistics extends StatefulWidget {
  @override
  _RevenueStatisticsState createState() => _RevenueStatisticsState();
}

class _RevenueStatisticsState extends State<RevenueStatistics> {
  String _selectedFilter = 'Daily';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RevenueChart(),
            SizedBox(height: TSize.spaceBetweenItemsVertical),
            SizedBox(height: TSize.spaceBetweenItemsVertical),
            _buildStatisticsGrid(),
          ],
        ),
      ),
    );
  }

  int totalOrders = 45;
  int boomOrders = 7;

  String get boomRate {
    double rate = (boomOrders / totalOrders) * 100;
    return '${rate.toStringAsFixed(1)}%';
  }


  Widget _buildStatisticsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1.2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        _buildStatCard('Total Orders', totalOrders.toString()),
        _buildStatCard('Average Order Value', '\$49.80'),
        _buildStatCard('Peak Hour', '24:00 PM -\n24:00 PM'),
        _buildStatCard('Total Revenue', '\$2,241'),
        _buildStatCard('Boom Orders', boomOrders.toString()),
        _buildStatCard('Boom Rate', boomRate),
      ],
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Card(
      elevation: TSize.cardElevationSm,
      child: Padding(
        padding: EdgeInsets.all(TSize.md),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: TSize.spaceBetweenItemsHorizontal),
            Text(
              "$value" ,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: TColor.primary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }


  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter by'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Day'),
                onTap: () => Navigator.pop(context, 'Day'),
              ),
              ListTile(
                title: Text('Week'),
                onTap: () => Navigator.pop(context, 'Week'),
              ),
              ListTile(
                title: Text('Month'),
                onTap: () => Navigator.pop(context, 'Month'),
              ),
              ListTile(
                title: Text('Year'),
                onTap: () => Navigator.pop(context, 'Year'),
              ),
              ListTile(
                title: Text('All Time'),
                onTap: () => Navigator.pop(context, 'All Time'),
              ),
            ],
          ),
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          _selectedFilter = value;
        });
      }
    });
  }
}