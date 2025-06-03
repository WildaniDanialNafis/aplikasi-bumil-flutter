class Hpl {
  final int idHpl;
  final DateTime hpl;
  final int usiaMinggu;
  final int usiaHari;
  final int sisaMinggu;
  final int sisaHari;
  final int mobileUserId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Hpl({
    required this.idHpl,
    required this.hpl,
    required this.usiaMinggu,
    required this.usiaHari,
    required this.sisaMinggu,
    required this.sisaHari,
    required this.mobileUserId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Hpl.fromJson(Map<String, dynamic> json) {
    return Hpl(
      idHpl: json['idHpl'],
      hpl: DateTime.parse(json['hpl']),
      usiaMinggu: json['usiaMinggu'],
      usiaHari: json['usiaHari'],
      sisaMinggu: json['sisaMinggu'],
      sisaHari:  json['sisaHari'],
      mobileUserId: json['mobileUserId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idHpl': idHpl,
      'hpl': hpl.toIso8601String(),
      'usiaMinggu': usiaMinggu,
      'usiaHari': usiaHari,
      'sisaMinggu': sisaMinggu,
      'sisaHari': sisaHari,
      'mobileUserId': mobileUserId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}