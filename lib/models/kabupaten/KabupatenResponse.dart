
import 'package:untitled/models/kabupaten/Kabupaten.dart';

class ListKabupatenResponse {
  final String status;
  final int code;
  final String message;
  final List<Kabupaten> data;
  final DateTime timestamp;

  ListKabupatenResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
    required this.timestamp
  });

  factory ListKabupatenResponse.fromJson(Map<String, dynamic> json) {
    return ListKabupatenResponse(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: (json['data'] as List)
          .map((kabupaten) => Kabupaten.fromJson(kabupaten))
          .toList(),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'code': code,
      'message': message,
      'data': data.map((kabupaten) => kabupaten.toJson()).toList(),
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
