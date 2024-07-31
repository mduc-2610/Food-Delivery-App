import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
@jsonSerializable
class RestaurantMenuDelivery {
  final String? menuImage;

  RestaurantMenuDelivery({
    required this.menuImage,
  });

  RestaurantMenuDelivery.fromJson(Map<String, dynamic> json)
      : menuImage = json['menu_image'];

  Map<String, dynamic> toJson() {
    return {
      'menu_image': menuImage,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}
