import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class THelperFunction {
  static Color? getColor(String value) {

    /// Define product and it will map the color from that product
    if(value == 'Green') {
      return Colors.green;
    }
    return null;
  }

  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(content: Text(message))
    );
  }

  static bool checkInArray(dynamic x, List<dynamic> ls) {
    return ls.contains(x);
  }

  static bool checkIfExistsNull(List<dynamic> ls) {
    return ls.contains(null);
  }

  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK')
            )
          ],
        );
      }
    );
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static String truncateText(String text, int maxLength) {
    if(text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength)}...';
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static String getFormattedDate(DateTime, date, { String format = 'dd MMMM yyyy' }) {
    return DateFormat(format).format(date);
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for(var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }

  static String formatToString(String className, Map<String, dynamic> attributes) {
    String formattedString = '$className {\n';
    attributes.forEach((key, value) {
      formattedString += '\t$key: $value,\n';
    });
    formattedString += '}';
    return formattedString;
  }

}
