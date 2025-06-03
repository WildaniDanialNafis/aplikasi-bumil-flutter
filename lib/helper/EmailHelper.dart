import 'package:shared_preferences/shared_preferences.dart';

class EmailHelper {

  static Future<String> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('email');
    if (token == null || token.isEmpty) {
      throw Exception('Email tidak tersedia');
    }
    return token;
  }

  static Future<String> getKode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? kode = prefs.getString('kode_verif');
    if (kode == null || kode.isEmpty) {
      throw Exception('Email tidak tersedia');
    }
    return kode;
  }

  static Future<int> getIdMobileUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? token = prefs.getInt('idMobileUser');

    if (token == null) {
      throw Exception('ID Mobile User tidak tersedia');
    }

    return token;
  }
}
