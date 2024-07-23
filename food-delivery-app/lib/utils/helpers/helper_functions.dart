import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/bars/snack_bar.dart';
import 'package:food_delivery_app/utils/constants/enums.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:flutter/material.dart';

class THelperFunction {
  static Color? getColor(String value) {

    if(value == 'Green') {
      return Colors.green;
    }
    return null;
  }

  static void showCSnackBar(BuildContext context, String message, SnackBarType type, { int duration = 2 }) {
    // final snackBar = CSnackBar(
    //     message: message,
    //     snackBarType: type,
    //
    // );
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    CSnackBar.show(context: context, message: message, snackBarType: type, duration: duration);
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
    String generate(String className, Map<String, dynamic> attributes, { bool prettyPrint = false }) {
      String endLine = prettyPrint ? '\n' : '';
      String tab = prettyPrint ? '\t' : '';
      String formattedString = '$className {$endLine';
      int i = 0;
      attributes.forEach((key, value) {
        formattedString += '$tab"$key": "$value"';
        if (i != attributes.length - 1) {
          formattedString += ",";
        }
        formattedString += "$endLine";
        i++;
      });
      formattedString += '}';
      return formattedString;
    }
    String result = generate(className, attributes, prettyPrint: false)
        + '\n' + generate(className, attributes, prettyPrint: true);
    return result;
  }

  static String getPhoneNumber(PhoneNumber phoneNumber, {
    bool excludeZero = true,
    bool excludePrefix = false,
  }) {
    String phoneNumberStr = phoneNumber.phoneNumber ?? "";
    int dialCodeLength = phoneNumber.dialCode?.length ?? 0;

    if (phoneNumberStr.length <= dialCodeLength) return "";

    String numberPart = phoneNumberStr.substring(dialCodeLength);

    if (excludeZero && numberPart.isNotEmpty && numberPart[0] == '0') {
      numberPart = numberPart.substring(1);
    }

    if(excludePrefix == false) numberPart = (phoneNumber.dialCode ?? "") + numberPart;
    return numberPart;
  }

  static String hidePhoneNumber(PhoneNumber phoneNumber) {
    String phoneNumberStr = THelperFunction.getPhoneNumber(phoneNumber, excludePrefix: true);
    int length = phoneNumberStr.length;
    String prefixVisiblePart = phoneNumberStr.substring(0, 2);
    String suffixVisiblePart = phoneNumberStr.substring(length - 3, length);
    return '(${phoneNumber.dialCode}) $prefixVisiblePart ***** $suffixVisiblePart';
  }

  static int getTimeFromThrottleStr(String x) {
    int time = 0;
    for (int i = 0; i < x.length; i++) {
      if (RegExp(r'\d').hasMatch(x[i])) {
        time = time * 10 + int.parse(x[i]);
      }
    }
    return time;
  }

  static int secondsUntilExpiration(DateTime expiredAt) {
    DateTime now = DateTime.now();
    Duration difference = expiredAt.difference(now);
    return difference.inSeconds;
  }
}

void $print(dynamic message) {
  var stackTrace = Trace.current();
  var frame = stackTrace.frames[1];
  var file = frame.uri;
  var line = frame.line;
  print('\n[$file:$line]\n$message\n');
}
