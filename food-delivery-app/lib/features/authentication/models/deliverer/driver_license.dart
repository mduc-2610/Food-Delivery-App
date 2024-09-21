import 'package:dio/dio.dart';
import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

@reflector
@jsonSerializable
class DelivererDriverLicense {
  String? deliverer;
  final dynamic driverLicenseFront;
  final dynamic driverLicenseBack;
  final dynamic motorcycleRegistrationCertificateFront;
  final dynamic motorcycleRegistrationCertificateBack;
  final String? vehicleType;
  final String? licensePlate;

  DelivererDriverLicense({
    this.deliverer,
    this.driverLicenseFront,
    this.driverLicenseBack,
    this.motorcycleRegistrationCertificateFront,
    this.motorcycleRegistrationCertificateBack,
    this.vehicleType,
    this.licensePlate,
  });

  DelivererDriverLicense.fromJson(Map<String, dynamic> json)
      : deliverer = json['deliverer'],
        driverLicenseFront = json['driver_license_front'],
        driverLicenseBack = json['driver_license_back'],
        motorcycleRegistrationCertificateFront = json['motorcycle_registration_certificate_front'],
        motorcycleRegistrationCertificateBack = json['motorcycle_registration_certificate_back'],
        vehicleType = json['vehicle_type'],
        licensePlate = json['license_plate'];

  Map<String, dynamic> toJson({bool patch = false}) {
    final Map<String, dynamic> data = {
      'deliverer': deliverer,
      'vehicle_type': vehicleType,
      'license_plate': licensePlate,
      'driver_license_front': driverLicenseFront is XFile ? driverLicenseFront.path : driverLicenseFront,
      'driver_license_back': driverLicenseBack is XFile ? driverLicenseBack.path : driverLicenseBack,
      'motorcycle_registration_certificate_front': motorcycleRegistrationCertificateFront is XFile
          ? motorcycleRegistrationCertificateFront.path
          : motorcycleRegistrationCertificateFront,
      'motorcycle_registration_certificate_back': motorcycleRegistrationCertificateBack is XFile
          ? motorcycleRegistrationCertificateBack.path
          : motorcycleRegistrationCertificateBack,
    };

    if (patch) {
      data.removeWhere((key, value) => value == null);
    }

    return data;
  }

  Future<MultipartFile?> get multiPartDriverLicenseFront =>
      THelperFunction.convertXToMultipartFile(driverLicenseFront);

  Future<MultipartFile?> get multiPartDriverLicenseBack =>
      THelperFunction.convertXToMultipartFile(driverLicenseBack);

  Future<MultipartFile?> get multiPartRegistrationCertificateFront =>
      THelperFunction.convertXToMultipartFile(motorcycleRegistrationCertificateFront);

  Future<MultipartFile?> get multiPartRegistrationCertificateBack =>
      THelperFunction.convertXToMultipartFile(motorcycleRegistrationCertificateBack);

  Future<FormData> toFormData({bool patch = false}) async {
    final Map<String, dynamic> formData = {
      'deliverer': deliverer,
      'vehicle_type': vehicleType,
      'license_plate': licensePlate,
      'driver_license_front': await multiPartDriverLicenseFront,
      'driver_license_back': await multiPartDriverLicenseBack,
      'motorcycle_registration_certificate_front': await multiPartRegistrationCertificateFront,
      'motorcycle_registration_certificate_back': await multiPartRegistrationCertificateBack,
    };

    if (patch) {
      formData.removeWhere((key, value) => value == null);
    }

    return FormData.fromMap(formData);
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}
