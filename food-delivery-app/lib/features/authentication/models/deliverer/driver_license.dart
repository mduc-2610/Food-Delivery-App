import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@jsonSerializable
class DelivererDriverLicense {
  final String? licenseFront;
  final String? licenseBack;
  final String? vehicleType;
  final String? licensePlate;
  final String? registrationCertificate;

  DelivererDriverLicense({
    this.licenseFront,
    this.licenseBack,
    this.vehicleType,
    this.licensePlate,
    this.registrationCertificate,
  });

  DelivererDriverLicense.fromJson(Map<String, dynamic> json)
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
    return THelperFunction.formatToString('DelivererDriverLicense', {
      'licenseFront': licenseFront,
      'licenseBack': licenseBack,
      'vehicleType': vehicleType,
      'licensePlate': licensePlate,
      'registrationCertificate': registrationCertificate,
    });
  }
}
