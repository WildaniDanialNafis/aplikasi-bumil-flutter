import 'package:untitled/models/tekanandarah/TekananDarah.dart';

class TekananDarahResponse {
  final String status;
  final int code;
  final String message;
  final TekananDarah data;
  final DateTime timestamp;

  TekananDarahResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
    required this.timestamp
  });

  factory TekananDarahResponse.fromJson(Map<String, dynamic> json) {
    return TekananDarahResponse(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: TekananDarah.fromJson(json['data']),
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