import 'package:untitled/models/error/ErrorDetails.dart';

class ErrorResponse {
  final String status;
  final int code;
  final String message;
  final ErrorDetails details;
  final DateTime timestamp;

  ErrorResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.details,
    required this.timestamp,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      details: ErrorDetails.fromJson(json['details']),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'code': code,
      'message': message,
      'details': details.toJson(),
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
