import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/controller/MobileUserController.dart';
import 'package:untitled/models/mobileuser/MobileUser.dart';

class ForgetPasswordEmailValidator {
  static Future<String?> validate(String? value) async {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }

    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    RegExp regExp = RegExp(emailPattern);

    if (!regExp.hasMatch(value)) {
      return 'Email tidak valid';
    }

    try {
      MobileUser? mobileUser = await MobileUserController.getMobileUserByEmail(value);

      if (mobileUser == null) {
        return 'Email belum terdaftar';
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('idMobileUser', mobileUser.idMobileUser);
      await prefs.setString('email', mobileUser.email);
    } catch (e) {
      return 'Terjadi kesalahan saat memeriksa email: $e';
    }

    return null;
  }

  static String? initValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }

    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    RegExp regExp = RegExp(emailPattern);

    if (!regExp.hasMatch(value)) {
      return 'Email tidak valid';
    }

    return null;
  }
}