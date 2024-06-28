import 'package:intl/intl.dart';

class TFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MM-yyyy').format(date);
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(amount);
  }

  String formatTime(int second_, { bool hasHour = true, hasMinute = true }) {
    String hour = (second_ ~/ 3600).toString().padLeft(2, '0');
    String minute = ((second_ % 3600) ~/ 60).toString().padLeft(2, '0');
    int second = second_ % 60;
    return "${hasHour ? hour + ":" : ""}${hasMinute ? minute + ":" : ""}:${second.toString().padLeft(2, '0')}";
  }

}