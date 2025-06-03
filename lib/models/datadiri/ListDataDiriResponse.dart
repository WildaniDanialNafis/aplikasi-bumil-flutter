import 'package:untitled/models/datadiri/DataDiri.dart';

class ListDataDiriResponse {
  final String status;
  final int code;
  final String message;
  final List<DataDiri> data;
  final DateTime timestamp;

  ListDataDiriResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
    required this.timestamp
  });

  factory ListDataDiriResponse.fromJson(Map<String, dynamic> json) {
    return ListDataDiriResponse(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: (json['data'] as List)
          .map((dataDiri) => DataDiri.fromJson(dataDiri))
          .toList(),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'code': code,
      'message': message,
      'data': data.map((dataDiri) => dataDiri.toJson()).toList(),
      'timestamp': timestamp.toIso8601String(),
    };
  }
}