import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:http_parser/http_parser.dart';
import 'package:food_delivery_app/common/widgets/bars/snack_bar.dart';
import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/constants/enums.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:reflectable/mirrors.dart';
import 'package:stack_trace/stack_trace.dart';

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

  static String formatDate(DateTime? date, {String format = 'dd MMMM yyyy, HH:mm'}) {
    if (date == null) {
      return 'N/A';
    }
    return DateFormat(format).format(date);
  }

  static String formatTime(DateTime date, { String format = 'HH:mm:ss' }) {
    return DateFormat(format).format(date);
  }

  static Future<dio.MultipartFile?> convertXToMultipartFile(dynamic file,
      {
        String? mediaType
      }) async {
    if (file is XFile) {
      return dio.MultipartFile.fromFile(
        file.path,
        filename: file.name,
        contentType: (mediaType != null)
            ? MediaType('image', mediaType)
            : null,
      );
    }
    return null;
  }

  static Future<List<dynamic>> convertListToMultipartFile(
      List<dynamic> files, {
        String? mediaType,
        bool getStrUrl = false,
      }) async {
    List<dio.MultipartFile?> multipartFiles = [];
    List<String> imageUrls = [];

    for (var file in files) {
      dio.MultipartFile? multipartFile = await convertXToMultipartFile(file, mediaType: mediaType);
      if (multipartFile != null) {
        multipartFiles.add(multipartFile);
      } else if (file is String) {
        imageUrls.add(file);
      }
    }

    if (getStrUrl) {
      return [multipartFiles, imageUrls];
    } else {
      return multipartFiles;
    }
  }


  static DateTime? parseDateNormalize(String? dateStr) {
    if (dateStr == null) return null;

    try {
      dateStr = dateStr.replaceAll(RegExp(r'([+-]\d{2}:\d{2}:\d{2})'), '+07:00');
      return DateTime.parse(dateStr).toLocal();
    } catch (e) {
      print('Error parsing date: $e');
      return null;
    }
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static String formatName(String input) {
    String cleaned = input.replaceAll(RegExp(r'[_\s]+'), ' ');

    cleaned = cleaned.replaceAll(RegExp(r'[^\w\s]'), '');

    List<String> words = cleaned.split(' ');

    words = words.map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).toList();

    return words.join(' ').trim();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for(var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }

  static String formatToString2(String className, Map<String, dynamic> attributes) {
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

  static String hidePhoneNumber(dynamic phoneNumber) {
    String phoneNumberStr = (phoneNumber is PhoneNumber)
        ? THelperFunction.getPhoneNumber(phoneNumber, excludePrefix: true)
        : phoneNumber;
    int length = phoneNumberStr.length;
    String prefixVisiblePart =  phoneNumberStr.substring(0, (phoneNumber is PhoneNumber) ? 2 : 3);
    String suffixVisiblePart = phoneNumberStr.substring(length - 3, length);
    return '(${phoneNumber is PhoneNumber ? phoneNumber.dialCode : prefixVisiblePart}) ${(phoneNumber is PhoneNumber) ? prefixVisiblePart : ""} ***** $suffixVisiblePart';
  }

  static DateTime? parseToDateTime(dynamic date) {
    if (date is String) {
      try {
        return DateFormat('dd/MM/yyyy').parse(date).toLocal();
      } catch (e) {
        return null;
      }
    } else if (date is DateTime) {
      return date;
    }
    return null;
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

  static String formatToString(Object instance) {
    var instanceMirror = reflector.reflect(instance);
    ClassMirror? classMirror = instanceMirror.type;
    var className = classMirror.simpleName;
    var attributes = <String, dynamic>{};

    while (classMirror != null) {
      classMirror.declarations.forEach((key, value) {
        if (value is VariableMirror) {
          var attributeValue = instanceMirror.invokeGetter(value.simpleName);

          // Check if the value is of type XFile
          if (attributeValue is XFile) {
            attributes[value.simpleName] = 'XFile: ${attributeValue.path}';
          }
          // Check if the value is of type MultipartFile
          else if (attributeValue is MultipartFile) {
            attributes[value.simpleName] = 'MultipartFile: ${attributeValue.filename}, Content-Type: ${attributeValue.contentType}';
          }
          // Handle other types as needed
          else {
            attributes[value.simpleName] = attributeValue;
          }
        }
      });
      classMirror = classMirror.superclass;
    }

    return _generate(className, attributes, prettyPrint: false) + '\n' +
        _generate(className, attributes, prettyPrint: true);
  }

  static String _generate(String className, Map<String, dynamic> attributes, {bool prettyPrint = false}) {
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

  static String formatChoice(String x, { bool reverse = false }) {
    if(!reverse) {
      return x.split(RegExp(r'[^a-zA-Z0-9]+'))
          .where((part) => part.isNotEmpty)
          .map((word) => word.toUpperCase())
          .join("_") ?? "";
    }
    return x.split('_')
        .map((word) => word.isNotEmpty
        ? word[0].toUpperCase() + word.substring(1).toLowerCase()
        : word)
        .join(' ') ?? "";
  }


  static String formatNumber(int number) {
    if (number >= 1000000000) {
      return (number / 1000000000).toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '') + 'b';
    } else if (number >= 1000000) {
      return (number / 1000000).toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '') + 'm';
    } else if (number >= 1000) {
      return (number / 1000).toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '') + 'k';
    } else {
      return number.toString();
    }
  }

  static double formatDouble(dynamic number) {
    if(number != null) {
      if(number is String) {
        try {
          return double.parse(number);
        }
        catch(e) {
          return 0.0;
        }
      }
      else if(number is int) {
        try {
          return number.toDouble();
        }
        catch(e) {
          return 0.0;
        }
      }
      return number;
    }
    return 0;
  }

  static Widget getValidImage(
      String? imageUrl, {
        String? defaultAsset,
        String? defaultNetworkAsset,
        double? width,
        double? height,
        double? radius,
      }) {
    return FutureBuilder<bool>(
      future: _checkImageValidity(imageUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasData && snapshot.data == true) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(radius ?? 0),
            child: Image.network(
              imageUrl!,
              width: width,
              height: height,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return getFallbackImage(
                  defaultAsset,
                  defaultNetworkAsset,
                  width: width,
                  height: height,
                  radius: radius,
                );
              },
            ),
          );
        } else {
          return getFallbackImage(
            defaultAsset,
            defaultNetworkAsset,
            width: width,
            height: height,
            radius: radius,
          );
        }
      },
    );
  }

  static Widget getFallbackImage(
      String? defaultAsset,
      String? defaultNetworkAsset, {
        double? width,
        double? height,
        double? radius,
      }) {
    if (defaultNetworkAsset != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: Image.network(
          defaultNetworkAsset,
          width: width,
          height: height,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(radius ?? 0),
              child: Image.asset(
                defaultAsset ?? TImage.hcBurger1,
                width: width,
                height: height,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: Image.asset(
          defaultAsset ?? TImage.hcBurger1,
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
      );
    }
  }

  static Future<bool> _checkImageValidity(String? imageUrl) async {
    if (imageUrl == null) return false;
    try {
      final response = await NetworkImage(imageUrl).obtainKey(ImageConfiguration());
      return true;
    } catch (e) {
      return false;
    }
  }

}

void $print(dynamic message) {
  var stackTrace = Trace.current();
  var frame = stackTrace.frames[1];
  var file = frame.uri;
  var line = frame.line;
  print('\n[$file:$line]\n$message\n');
}
