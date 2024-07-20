import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class User {
  final String? id;
  final String? phoneNumber;
  final String? email;
  final bool? isActive;
  final bool? isStaff;
  final bool? isSuperuser;
  final DateTime? dateJoined;
  final DateTime? lastLogin;
  final bool? isOtpVerified;
  final bool? isRegistrationVerified;

  User({
    required this.id,
    required this.phoneNumber,
    this.email,
    required this.isActive,
    required this.isStaff,
    required this.isSuperuser,
    required this.dateJoined,
    required this.lastLogin,
    required this.isOtpVerified,
    required this.isRegistrationVerified,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        phoneNumber = json['phone_number'],
        email = json['email'],
        isActive = json['is_active'],
        isStaff = json['is_staff'],
        isSuperuser = json['is_superuser'],
        dateJoined = DateTime.parse(json['date_joined']),
        lastLogin = DateTime.parse(json['last_login']),
        isOtpVerified = json['is_otp_verified'],
        isRegistrationVerified = json['is_registration_verified'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone_number': phoneNumber,
      'email': email,
      'is_active': isActive,
      'is_staff': isStaff,
      'is_superuser': isSuperuser,
      'date_joined': dateJoined?.toIso8601String(),
      'last_login': lastLogin?.toIso8601String(),
      'is_otp_verified': isOtpVerified,
      'is_registration_verified': isRegistrationVerified,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('User', {
      'id': id,
      'phoneNumber': phoneNumber,
      'email': email,
      'isActive': isActive,
      'isStaff': isStaff,
      'isSuperuser': isSuperuser,
      'dateJoined': dateJoined,
      'lastLogin': lastLogin,
      'isOtpVerified': isOtpVerified,
      'isRegistrationVerified': isRegistrationVerified,
    });
  }
}

class OTP {
  final String? id;
  final User? user;
  final String? code;
  final DateTime? expiredAt;

  OTP({
    required this.id,
    required this.user,
    required this.code,
    required this.expiredAt,
  });

  OTP.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = User.fromJson(json['user']),
        code = json['code'],
        expiredAt = DateTime.parse(json['expired_at']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user?.toJson(),
      'code': code,
      'expired_at': expiredAt?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('OTP', {
      'id': id,
      'user': user,
      'code': code,
      'expiredAt': expiredAt,
    });
  }
}