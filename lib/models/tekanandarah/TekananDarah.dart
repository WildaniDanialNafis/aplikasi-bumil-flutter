class TekananDarah {
  final int idTekananDarah;
  final int sistolik;
  final int diastolik;
  final int mobileUserId;
  final DateTime createdAt;
  final DateTime updatedAt;

  TekananDarah({
    required this.idTekananDarah,
    required this.sistolik,
    required this.diastolik,
    required this.mobileUserId,
    required this.createdAt,
    required this.updatedAt
  });

  factory TekananDarah.fromJson(Map<String, dynamic> json) {
    return TekananDarah(
      idTekananDarah: json['idTekananDarah'],
      sistolik: json['sistolik'],
      diastolik: json['diastolik'],
      mobileUserId: json['mobileUserId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idTekananDarah': idTekananDarah,
      'sistolik': sistolik,
      'diastolik': diastolik,
      'mobileUserId': mobileUserId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}