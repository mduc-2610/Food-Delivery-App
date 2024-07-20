import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class Representative {
  final String? registrationType;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? otherPhoneNumber;
  final String? idFrontImage;
  final String? idBackImage;
  final String? businessRegistrationImage;

  Representative({
    required this.registrationType,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.otherPhoneNumber,
    required this.idFrontImage,
    required this.idBackImage,
    required this.businessRegistrationImage,
  });

  Representative.fromJson(Map<String, dynamic> json)
      : registrationType = json['registration_type'],
        fullName = json['full_name'],
        email = json['email'],
        phoneNumber = json['phone_number'],
        otherPhoneNumber = json['other_phone_number'],
        idFrontImage = json['id_front_image'],
        idBackImage = json['id_back_image'],
        businessRegistrationImage = json['business_registration_image'];

  Map<String, dynamic> toJson() {
    return {
      'registration_type': registrationType,
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
      'other_phone_number': otherPhoneNumber,
      'id_front_image': idFrontImage,
      'id_back_image': idBackImage,
      'business_registration_image': businessRegistrationImage,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('Representative', {
      'registrationType': registrationType,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'otherPhoneNumber': otherPhoneNumber,
      'idFrontImage': idFrontImage,
      'idBackImage': idBackImage,
      'businessRegistrationImage': businessRegistrationImage,
    });
  }
}
