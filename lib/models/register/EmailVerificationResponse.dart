class EmailVerificationResponse {
  final String status;
  final int code;
  final String message;
  final String timestamp;

  EmailVerificationResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.timestamp,
  });

  factory EmailVerificationResponse.fromJson(Map<String, dynamic> json) {
    return EmailVerificationResponse(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      timestamp: json['timestamp'],
    );
  }
}