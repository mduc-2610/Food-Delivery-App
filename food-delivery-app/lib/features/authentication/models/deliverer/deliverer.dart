import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/address.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/basic_info.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/driver_license.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/emergency_contact.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/operation_info.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/other_info.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/residency_info.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class Deliverer {
  final String id;
  final User? user;
  final DelivererBasicInfo? basicInfo;
  final DelivererResidencyInfo? residencyInfo;
  final DelivererDriverLicense? driverLicenseAndVehicle;
  final DelivererOtherInfo? otherInfo;
  final DelivererAddress? address;
  final DelivererOperationInfo? operationInfo;
  final DelivererEmergencyContact? emergencyContact;

  Deliverer({
    required this.id,
    required this.user,
    required this.basicInfo,
    required this.residencyInfo,
    required this.driverLicenseAndVehicle,
    required this.otherInfo,
    required this.address,
    required this.operationInfo,
    required this.emergencyContact,
  });

  Deliverer.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'] != null ? User.fromJson(json['user']) : null,
        basicInfo = json['basic_info'] != null ? DelivererBasicInfo.fromJson(json['basic_info']) : null,
        residencyInfo = json['residency_info'] != null ? DelivererResidencyInfo.fromJson(json['residency_info']) : null,
        driverLicenseAndVehicle = json['driver_license_and_vehicle'] != null ? DelivererDriverLicense.fromJson(json['driver_license_and_vehicle']) : null,
        otherInfo = json['other_info'] != null ? DelivererOtherInfo.fromJson(json['other_info']) : null,
        address = json['address'] != null ? DelivererAddress.fromJson(json['address']) : null,
        operationInfo = json['operation_info'] != null ? DelivererOperationInfo.fromJson(json['operation_info']) : null,
        emergencyContact = json['emergency_contact'] != null ? DelivererEmergencyContact.fromJson(json['emergency_contact']) : null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user?.toJson(),
      'basic_info': basicInfo?.toJson(),
      'residency_info': residencyInfo?.toJson(),
      'driver_license_and_vehicle': driverLicenseAndVehicle?.toJson(),
      'other_info': otherInfo?.toJson(),
      'address': address?.toJson(),
      'operation_info': operationInfo?.toJson(),
      'emergency_contact': emergencyContact?.toJson(),
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('Deliverer', {
      'id': id,
      'user': user,
      'basicInfo': basicInfo,
      'residencyInfo': residencyInfo,
      'driverLicenseAndVehicle': driverLicenseAndVehicle,
      'otherInfo': otherInfo,
      'address': address,
      'operationInfo': operationInfo,
      'emergencyContact': emergencyContact,
    });
  }
}
