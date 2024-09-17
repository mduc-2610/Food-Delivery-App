import 'package:dio/dio.dart';
import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

@reflector
@jsonSerializable
class RestaurantRepresentative {
  final String? registrationType;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? otherPhoneNumber;
  final dynamic citizenIdentificationFront;
  final dynamic citizenIdentificationBack;
  final dynamic businessRegistrationImage;

  RestaurantRepresentative({
    this.registrationType,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.otherPhoneNumber,
    this.citizenIdentificationFront,
    this.citizenIdentificationBack,
    this.businessRegistrationImage,
  });

  RestaurantRepresentative.fromJson(Map<String, dynamic> json)
      : registrationType = json['registration_type'],
        fullName = json['full_name'],
        email = json['email'],
        phoneNumber = json['phone_number'],
        otherPhoneNumber = json['other_phone_number'],
        citizenIdentificationFront = json['citizen_identification_front'],
        citizenIdentificationBack = json['citizen_identification_back'],
        businessRegistrationImage = json['business_registration_image'];

  Map<String, dynamic> toJson() {
    return {
      'registration_type': registrationType,
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
      'other_phone_number': otherPhoneNumber,
      'citizen_identification_front': citizenIdentificationFront is XFile ? citizenIdentificationFront.path : citizenIdentificationFront,
      'citizen_identification_back': citizenIdentificationBack is XFile ? citizenIdentificationBack.path : citizenIdentificationBack,
      'business_registration_image': businessRegistrationImage is XFile ? businessRegistrationImage.path : businessRegistrationImage,
    };
  }

  Future<MultipartFile?> get multiPartCitizenIdentificationFront
    => THelperFunction.convertXToMultipartFile(citizenIdentificationFront, mediaType: 'jpeg');

  Future<MultipartFile?> get multiPartCitizenIdentificationBack
    => THelperFunction.convertXToMultipartFile(citizenIdentificationBack, mediaType: 'jpeg');

  Future<MultipartFile?> get multiPartBusinessRegistrationImage
    => THelperFunction.convertXToMultipartFile(businessRegistrationImage, mediaType: 'jpeg');

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'registration_type': registrationType,
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
      'other_phone_number': otherPhoneNumber,
      'citizen_identification_front': await multiPartCitizenIdentificationFront,
      'citizen_identification_back': await multiPartCitizenIdentificationBack,
      'business_registration_image': await multiPartBusinessRegistrationImage,
    });
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}
