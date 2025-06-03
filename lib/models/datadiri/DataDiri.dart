class DataDiri {
  final int idDataDiri;
  final String namaLengkap;
  final String tempatLahir;
  final DateTime tanggaLahir;
  final String jenisKelamin;
  final String provinsi;
  final String kabupaten;
  final String alamat;
  final String nomorTelepon;
  final int mobileUserId;
  final DateTime createdAt;
  final DateTime updatedAt;

  DataDiri({
    required this.idDataDiri,
    required this.namaLengkap,
    required this.tempatLahir,
    required this.tanggaLahir,
    required this.jenisKelamin,
    required this.provinsi,
    required this.kabupaten,
    required this.alamat,
    required this.nomorTelepon,
    required this.mobileUserId,
    required this.createdAt,
    required this.updatedAt
  });

  factory DataDiri.fromJson(Map<String, dynamic> json) {
    return DataDiri(
      idDataDiri: json['idDataDiri'],
      namaLengkap: json['namaLengkap'],
      tempatLahir: json['tempatLahir'],
      tanggaLahir: DateTime.parse(json['tanggalLahir']),
      jenisKelamin: json['jenisKelamin'],
      provinsi: json['provinsi'],
      kabupaten: json['kabupaten'],
      alamat: json['alamat'],
      nomorTelepon: json['nomorTelepon'],
      mobileUserId: json['mobileUserId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idDataDiri': idDataDiri,
      'namaLengkap': namaLengkap,
      'tempatLahir': tempatLahir,
      'tanggalLahir': tanggaLahir.toIso8601String(),
      'jenisKelamin': jenisKelamin,
      'provinsi': provinsi,
      'kabupaten': kabupaten,
      'alamat': alamat,
      'nomorTelepon': nomorTelepon,
      'mobileUserId': mobileUserId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}