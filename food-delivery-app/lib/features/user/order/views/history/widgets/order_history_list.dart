import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/cards/order_history_card.dart';
import 'package:get/get.dart';


class OrderHistoryList extends StatelessWidget {
  final List<Map<String, dynamic>> orders;
  final String selectedFilter;

  const OrderHistoryList({
    Key? key,
    required this.orders,
    required this.selectedFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Map<String, dynamic>> _filteredOrders = orders.where((order) {
      if (selectedFilter == 'All') return true;
      return order['status'] == selectedFilter || order['rating'].toString() == selectedFilter;
    }).toList();


    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: _filteredOrders.length,
      itemBuilder: (context, index) {
        return OrderHistoryCard(order: _filteredOrders[index]);
      },
    );
  }
}