class BooleanMobileUserResponse {
  final String status;
  final int code;
  final String message;
  final bool data;
  final DateTime timestamp;

  BooleanMobileUserResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
    required this.timestamp
  });

  factory BooleanMobileUserResponse.fromJson(Map<String, dynamic> json) {
    return BooleanMobileUserResponse(
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