import 'package:untitled/models/hpl/Hpl.dart';

class ListHplResponse {
  final String status;
  final int code;
  final String message;
  final List<Hpl> data;
  final DateTime timestamp;

  ListHplResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
    required this.timestamp
  });

  factory ListHplResponse.fromJson(Map<String, dynamic> json) {
    return ListHplResponse(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: (json['data'] as List)
          .map((hpl) => Hpl.fromJson(hpl))
          .toList(),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'code': code,
      'message': message,
      'data': data.map((hpl) => hpl.toJson()).toList(),
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
