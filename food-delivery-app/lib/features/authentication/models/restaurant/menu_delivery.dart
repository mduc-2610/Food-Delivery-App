import 'package:dio/dio.dart';
import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

@reflector
@jsonSerializable
class RestaurantMenuDelivery {
  String? restaurant;
  final dynamic menuImage;

  RestaurantMenuDelivery({
    this.restaurant,
    this.menuImage,
  });

  RestaurantMenuDelivery.fromJson(Map<String, dynamic> json)
      : restaurant = json['restaurant'],
        menuImage = json['menu_image'];

  Map<String, dynamic> toJson({bool patch = false}) {
    final data = {
      'restaurant': restaurant,
      'menu_image': menuImage is XFile ? menuImage.path : menuImage,
    };

    if (patch) {
      data.removeWhere((key, value) => value == null);
    }

    return data;
  }

  Future<MultipartFile?> get multiPartMenuImage
    => THelperFunction.convertXToMultipartFile(menuImage, mediaType: 'jpeg');

  Future<FormData> toFormData({bool patch = false}) async {
    final data = {
      'restaurant': restaurant,
      'menu_image': await multiPartMenuImage,
    };

    if (patch) {
      data.removeWhere((key, value) => value == null);
    }

    return FormData.fromMap(data);
  }


  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}
