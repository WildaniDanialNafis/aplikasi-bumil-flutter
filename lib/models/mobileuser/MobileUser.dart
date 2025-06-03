class MobileUser {
  final int idMobileUser;
  final String email;
  final String password;
  final DateTime createdAt;
  final DateTime updatedAt;

  MobileUser({
    required this.idMobileUser,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MobileUser.fromJson(Map<String, dynamic> json) {
    return MobileUser(
      idMobileUser: json['idMobileUser'],
      email: json['email'],
      password: json['password'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idMobileUser': idMobileUser,
      'email': email,
      'password': password,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}