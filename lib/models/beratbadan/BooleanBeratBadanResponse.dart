class BooleanBeratBadanResponse {
  final String status;
  final int code;
  final String message;
  final bool data;
  final DateTime timestamp;

  BooleanBeratBadanResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
    required this.timestamp
  });

  factory BooleanBeratBadanResponse.fromJson(Map<String, dynamic> json) {
    return BooleanBeratBadanResponse(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: json['data'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'code': code,
      'message': message,
      'data': data,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}