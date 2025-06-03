class ErrorDetails {
  final String errorType;
  final String resource;

  ErrorDetails({
    required this.errorType,
    required this.resource,
  });

  factory ErrorDetails.fromJson(Map<String, dynamic> json) {
    return ErrorDetails(
      errorType: json['errorType'],
      resource: json['resource'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'errorType': errorType,
      'resource': resource,
    };
  }
}