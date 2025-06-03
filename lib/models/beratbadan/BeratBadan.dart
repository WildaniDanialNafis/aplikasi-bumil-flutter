class BeratBadan {
  final int idBeratBadan;
  final double beratBadan;
  final int mobileUserId;
  final DateTime createdAt;
  final DateTime updatedAt;

  BeratBadan({
    required this.idBeratBadan,
    required this.beratBadan,
    required this.mobileUserId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BeratBadan.fromJson(Map<String, dynamic> json) {
    return BeratBadan(
      idBeratBadan: json['idBeratBadan'],
      beratBadan: double.parse(json['beratBadan'].toString()),
      mobileUserId: json['mobileUserId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idBeratBadan': idBeratBadan,
      'beratBadan': beratBadan,
      'mobileUserId': mobileUserId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}