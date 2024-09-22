import 'package:dio/dio.dart';
import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

@reflector
@jsonSerializable
class RestaurantRepresentativeInfo {
  String? restaurant;
  final String? registrationType;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? otherPhoneNumber;
  final String? taxCode;
  final String? citizenIdentification;
  final dynamic citizenIdentificationFront;
  final dynamic citizenIdentificationBack;
  final dynamic businessRegistrationImage;

  RestaurantRepresentativeInfo({
    this.restaurant,
    this.registrationType,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.otherPhoneNumber,
    this.taxCode,
    this.citizenIdentification,
    this.citizenIdentificationFront,
    this.citizenIdentificationBack,
    this.businessRegistrationImage,
  });

  RestaurantRepresentativeInfo.fromJson(Map<String, dynamic> json)
      : restaurant = json['restaurant'],
        registrationType = json['registration_type'],
        fullName = json['full_name'],
        email = json['email'],
        phoneNumber = json['phone_number'],
        otherPhoneNumber = json['other_phone_number'],
        taxCode = json['tax_code'],
        citizenIdentification = json['citizen_identification'],
        citizenIdentificationFront = json['citizen_identification_front'],
        citizenIdentificationBack = json['citizen_identification_back'],
        businessRegistrationImage = json['business_registration_image'];

  String get convertRegistrationType {
    if (registrationType?.toLowerCase().contains("chuỗi") ?? false) {
      return "RESTAURANT_CHAIN";
    } else if (registrationType?.toLowerCase().contains("cá nhân") ?? false) {
      return "INDIVIDUAL";
    }

    return THelperFunction.formatChoice(registrationType ?? "");
  }

  Map<String, dynamic> toJson({bool patch = false}) {
    final data = {
      'restaurant': restaurant,
      'registration_type': convertRegistrationType,
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
      'other_phone_number': otherPhoneNumber,
      'tax_code': taxCode,
      'citizen_identification': citizenIdentification,
      'citizen_identification_front': citizenIdentificationFront is XFile ? citizenIdentificationFront.path : citizenIdentificationFront,
      'citizen_identification_back': citizenIdentificationBack is XFile ? citizenIdentificationBack.path : citizenIdentificationBack,
      'business_registration_image': businessRegistrationImage is XFile ? businessRegistrationImage.path : businessRegistrationImage,
    };

    if (patch) {
      data.removeWhere((key, value) => value == null);
    }
    $print("$patch $data");

    return data;
  }


  Future<MultipartFile?> get multiPartCitizenIdentificationFront
    => THelperFunction.convertXToMultipartFile(citizenIdentificationFront);

  Future<MultipartFile?> get multiPartCitizenIdentificationBack
    => THelperFunction.convertXToMultipartFile(citizenIdentificationBack);

  Future<MultipartFile?> get multiPartBusinessRegistrationImage
    => THelperFunction.convertXToMultipartFile(businessRegistrationImage);

  Future<FormData> toFormData({bool patch = false}) async {
    final data = {
      'restaurant': restaurant,
      'registration_type': convertRegistrationType,
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
      'other_phone_number': otherPhoneNumber,
      'tax_code': taxCode,
      'citizen_identification': citizenIdentification,
      'citizen_identification_front': await multiPartCitizenIdentificationFront,
      'citizen_identification_back': await multiPartCitizenIdentificationBack,
      'business_registration_image': await multiPartBusinessRegistrationImage,
    };

    if (patch) {
      data.removeWhere((key, value) => value == null);
    }
    $print("$patch $data");

    return FormData.fromMap(data);
  }


  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}
