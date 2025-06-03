import 'package:untitled/models/hpl/Hpl.dart';

class HplResponse {
  final String status;
  final int code;
  final String message;
  final Hpl data;
  final DateTime timestamp;

  HplResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
    required this.timestamp
  });

  factory HplResponse.fromJson(Map<String, dynamic> json) {
    return HplResponse(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: Hpl.fromJson(json['data']),
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
