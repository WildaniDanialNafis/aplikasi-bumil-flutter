import 'package:untitled/models/beratbadan/BeratBadan.dart';

class ListBeratBadanResponse {
  final String status;
  final int code;
  final String message;
  final List<BeratBadan> data;
  final DateTime timestamp;

  ListBeratBadanResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
    required this.timestamp
  });

  factory ListBeratBadanResponse.fromJson(Map<String, dynamic> json) {
    return ListBeratBadanResponse(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: (json['data'] as List)
          .map((beratBadan) => BeratBadan.fromJson(beratBadan))
          .toList(),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'code': code,
      'message': message,
      'data': data.map((beratBadan) => beratBadan.toJson()).toList(),
      'timestamp': timestamp.toIso8601String(),
    };
  }
}