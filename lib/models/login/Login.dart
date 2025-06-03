import 'package:untitled/models/mobileuser/MobileUser.dart';

class Login {
  final MobileUser mobileUser;
  final String token;

  Login({
    required this.mobileUser,
    required this.token,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      mobileUser: MobileUser.fromJson(json['mobileUser']),
      token: json['token'],
    );
  }
}