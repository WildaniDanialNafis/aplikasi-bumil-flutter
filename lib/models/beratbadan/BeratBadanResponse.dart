import 'package:untitled/models/beratbadan/BeratBadan.dart';

class BeratBadanResponse {
  final String status;
  final int code;
  final String message;
  final BeratBadan data;
  final DateTime timestamp;

  BeratBadanResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
    required this.timestamp
  });

  factory BeratBadanResponse.fromJson(Map<String, dynamic> json) {
    return BeratBadanResponse(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: BeratBadan.fromJson(json['data']),
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