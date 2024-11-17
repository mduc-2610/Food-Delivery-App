import 'package:dio/dio.dart';
import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/features/user/food/models/food/category.dart';
import 'package:food_delivery_app/features/user/food/models/food/option.dart';
import 'package:food_delivery_app/main.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:image_picker/image_picker.dart';

@reflector
@jsonSerializable
class Weather {
  final int? temperature;
  final String? weatherDescription;
  final int? humidity;

  Weather({
    this.temperature,
    this.weatherDescription,
    this.humidity
  });

  Weather.fromJson(Map<String, dynamic> json)
    : temperature = json['temperature'],
      weatherDescription = json['weather_description'],
      humidity = json['humidity'];

  @override toString() {
    return THelperFunction.formatToString(this);
  }
}