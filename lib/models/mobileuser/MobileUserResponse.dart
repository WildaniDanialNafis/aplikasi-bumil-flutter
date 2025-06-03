import 'package:untitled/models/mobileuser/MobileUser.dart';

class MobileUserResponse {
  final String status;
  final int code;
  final String message;
  final MobileUser data;
  final DateTime timestamp;

  MobileUserResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
    required this.timestamp
  });

  factory MobileUserResponse.fromJson(Map<String, dynamic> json) {
    return MobileUserResponse(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: MobileUser.fromJson(json['data']),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'code': code,
      'message': message,
      'data': data.toJson(),
      'timestamp': timestamp.toIso8601String(),
    };
  }
}