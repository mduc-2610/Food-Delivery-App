import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class DriverLicense {
  final String? licenseFront;
  final String? licenseBack;
  final String? vehicleType;
  final String? licensePlate;
  final String? registrationCertificate;

  DriverLicense({
    required this.licenseFront,
    required this.licenseBack,
    required this.vehicleType,
    required this.licensePlate,
    required this.registrationCertificate,
  });

  DriverLicense.fromJson(Map<String, dynamic> json)
      : licenseFront = json['license_front'],
        licenseBack = json['license_back'],
        vehicleType = json['vehicle_type'],
        licensePlate = json['license_plate'],
        registrationCertificate = json['registration_certificate'];

  Map<String, dynamic> toJson() {
    return {
      'license_front': licenseFront,
      'license_back': licenseBack,
      'vehicle_type': vehicleType,
      'license_plate': licensePlate,
      'registration_certificate': registrationCertificate,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('DriverLicense', {
      'licenseFront': licenseFront,
      'licenseBack': licenseBack,
      'vehicleType': vehicleType,
      'licensePlate': licensePlate,
      'registrationCertificate': registrationCertificate,
    });
  }
}
