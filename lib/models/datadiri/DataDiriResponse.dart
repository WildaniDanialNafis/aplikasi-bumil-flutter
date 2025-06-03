import 'package:untitled/models/datadiri/DataDiri.dart';

class DataDiriResponse {
  final String status;
  final int code;
  final String message;
  final DataDiri data;
  final DateTime timestamp;

  DataDiriResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
    required this.timestamp
  });

  factory DataDiriResponse.fromJson(Map<String, dynamic> json) {
    return DataDiriResponse(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: DataDiri.fromJson(json['data']),
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