import 'package:dio/dio.dart';
import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

@reflector
@jsonSerializable
class DelivererDriverLicense {
  final dynamic driverLicenseFront;
  final dynamic driverLicenseBack;
  final dynamic motorcycleRegistrationCertificateFront;
  final dynamic motorcycleRegistrationCertificateBack;
  final String? vehicleType;
  final String? licensePlate;

  DelivererDriverLicense({
    this.driverLicenseFront,
    this.driverLicenseBack,
    this.motorcycleRegistrationCertificateFront,
    this.motorcycleRegistrationCertificateBack,
    this.vehicleType,
    this.licensePlate,
  });

  DelivererDriverLicense.fromJson(Map<String, dynamic> json)
      : driverLicenseFront = json['driver_license_front'],
        driverLicenseBack = json['driver_license_back'],
        motorcycleRegistrationCertificateFront = json['motorcycle_registration_certificate_front'],
        motorcycleRegistrationCertificateBack = json['motorcycle_registration_certificate_back'],
        vehicleType = json['vehicle_type'],
        licensePlate = json['license_plate'];

  Map<String, dynamic> toJson() {
    return {
      'driver_license_front': driverLicenseFront is XFile ? driverLicenseFront.path : driverLicenseFront,
      'driver_license_back': driverLicenseBack is XFile ? driverLicenseBack.path : driverLicenseBack,
      'motorcycle_registration_certificate_front': motorcycleRegistrationCertificateFront is XFile ? motorcycleRegistrationCertificateFront.path : motorcycleRegistrationCertificateFront,
      'motorcycle_registration_certificate_back': motorcycleRegistrationCertificateBack is XFile ? motorcycleRegistrationCertificateBack.path : motorcycleRegistrationCertificateBack,
      'vehicle_type': vehicleType,
      'license_plate': licensePlate,
    };
  }

  Future<MultipartFile?> get multiPartDriverLicenseFront
    => THelperFunction.convertXToMultipartFile(driverLicenseFront, mediaType: 'jpeg');

  Future<MultipartFile?> get multiPartDriverLicenseBack
    => THelperFunction.convertXToMultipartFile(driverLicenseBack, mediaType: 'jpeg');

  Future<MultipartFile?> get multiPartRegistrationCertificateFront
    => THelperFunction.convertXToMultipartFile(motorcycleRegistrationCertificateFront, mediaType: 'jpeg');

  Future<MultipartFile?> get multiPartRegistrationCertificateBack
    => THelperFunction.convertXToMultipartFile(motorcycleRegistrationCertificateBack, mediaType: 'jpeg');

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'vehicle_type': vehicleType,
      'license_plate': licensePlate,
      'driver_license_front': await multiPartDriverLicenseFront,
      'driver_license_back': await multiPartDriverLicenseBack,
      'motorcycle_registration_certificate_front': await multiPartRegistrationCertificateFront,
      'motorcycle_registration_certificate_back': await multiPartRegistrationCertificateBack,
    });
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}
