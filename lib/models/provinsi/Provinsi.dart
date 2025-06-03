class Provinsi {
  final String code;
  final String name;

  Provinsi({
    required this.code,
    required this.name,
  });

  factory Provinsi.fromJson(Map<String, dynamic> json) {
    return Provinsi(
      code: json['code'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
    };
  }
}