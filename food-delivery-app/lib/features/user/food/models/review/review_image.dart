
import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@jsonSerializable
@reflector
class ReviewImage {
  final String? id;
  final String? image;
  final String? objectId;
  final String? contentType;

  ReviewImage({
    this.id,
    this.image,
    this.objectId,
    this.contentType,
  });

  Map<String, dynamic> toJson({ bool patch = false }) {
    Map<String, dynamic> data = {
      'id': id,
      'image': image,
      'object_id': objectId,
      'content_type': contentType,
    };

    if(patch) {
      data.removeWhere((key, value) => value == null);
    }

    return data;
  }

  ReviewImage.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        image = json['image'],
        objectId = json['object_id'],
        contentType = json['content_type'];

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}