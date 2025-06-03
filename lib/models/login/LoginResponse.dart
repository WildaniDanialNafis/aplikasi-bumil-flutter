import 'package:untitled/models/login/Login.dart';

class LoginResponse {
  final String status;
  final int code;
  final String message;
  final Login data;
  final String timestamp;

  LoginResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
    required this.timestamp,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: Login.fromJson(json['data']),
      timestamp: json['timestamp'],
    );
  }
}
