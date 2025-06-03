import 'package:untitled/models/provinsi/Provinsi.dart';

class ListProvinsiResponse {
  final String status;
  final int code;
  final String message;
  final List<Provinsi> data;
  final DateTime timestamp;

  ListProvinsiResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
    required this.timestamp
  });

  factory ListProvinsiResponse.fromJson(Map<String, dynamic> json) {
    return ListProvinsiResponse(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: (json['data'] as List)
          .map((provinsi) => Provinsi.fromJson(provinsi))
          .toList(),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'code': code,
      'message': message,
      'data': data.map((provinsi) => provinsi.toJson()).toList(),
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
