class EmailCodeResponse {
  final String status;
  final int code;
  final String message;
  final Data data;
  final String timestamp;

  EmailCodeResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
    required this.timestamp,
  });

  factory EmailCodeResponse.fromJson(Map<String, dynamic> json) {
    return EmailCodeResponse(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: Data.fromJson(json['data']),
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'code': code,
      'message': message,
      'data': data.toJson(),
      'timestamp': timestamp,
    };
  }
}

class Data {
  final String kode;

  Data({required this.kode});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      kode: json['kode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kode': kode,
    };
  }
}
