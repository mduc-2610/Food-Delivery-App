import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class MenuDelivery {
  final String? menuImage;

  MenuDelivery({
    required this.menuImage,
  });

  MenuDelivery.fromJson(Map<String, dynamic> json)
      : menuImage = json['menu_image'];

  Map<String, dynamic> toJson() {
    return {
      'menu_image': menuImage,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('MenuDelivery', {
      'menuImage': menuImage,
    });
  }
}
