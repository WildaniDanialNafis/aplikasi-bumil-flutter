import 'package:untitled/models/tekanandarah/TekananDarah.dart';

class ListTekananDarahResponse {
  final String status;
  final int code;
  final String message;
  final List<TekananDarah> data;
  final DateTime timestamp;

  ListTekananDarahResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
    required this.timestamp
  });


  factory ListTekananDarahResponse.fromJson(Map<String, dynamic> json) {
    return ListTekananDarahResponse(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: (json['data'] as List)
          .map((tekananDarah) => TekananDarah.fromJson(tekananDarah))
          .toList(),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'code': code,
      'message': message,
      'data': data.map((tekananDarah) => tekananDarah.toJson()).toList(),
      'timestamp': timestamp.toIso8601String(),
    };
  }
}