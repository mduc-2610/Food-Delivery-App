import 'package:dio/dio.dart';
import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

@reflector
@jsonSerializable
class RestaurantMenuDelivery {
  final dynamic menuImage;

  RestaurantMenuDelivery({
    required this.menuImage,
  });

  RestaurantMenuDelivery.fromJson(Map<String, dynamic> json)
      : menuImage = json['menu_image'];

  Map<String, dynamic> toJson() {
    return {
      'menu_image': menuImage is XFile ? menuImage.path : menuImage,
    };
  }

  Future<MultipartFile?> get multiPartMenuImage
    => THelperFunction.convertXToMultipartFile(menuImage, mediaType: 'jpeg');

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'menu_image': await multiPartMenuImage,
    });
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}
