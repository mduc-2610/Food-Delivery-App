import 'package:dio/dio.dart';
import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

@reflector
@jsonSerializable
class DelivererDriverLicense {
  final dynamic licenseFront;
  final dynamic licenseBack;
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
      'license_front': licenseFront is XFile ? licenseFront.path : licenseFront,
      'license_back': licenseBack is XFile ? licenseBack.path : licenseBack,
      'vehicle_type': vehicleType,
      'license_plate': licensePlate,
      'registration_certificate': registrationCertificate,
    };
  }

  Future<MultipartFile?> get multiPartLicenseFront async {
    if (licenseFront is XFile) {
      return MultipartFile.fromFile(
        (licenseFront as XFile).path,
        filename: (licenseFront as XFile).name,
        contentType: MediaType('image', 'jpeg'),
      );
    }
    return null;
  }

  Future<MultipartFile?> get multiPartLicenseBack async {
    if (licenseBack is XFile) {
      return MultipartFile.fromFile(
        (licenseBack as XFile).path,
        filename: (licenseBack as XFile).name,
        contentType: MediaType('image', 'jpeg'),
      );
    }
    return null;
  }

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'vehicle_type': vehicleType,
      'license_plate': licensePlate,
      'registration_certificate': registrationCertificate,
      'license_front': await multiPartLicenseFront,
      'license_back': await multiPartLicenseBack,
    });
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}
