import 'package:untitled/controller/MobileUserController.dart';
import 'package:untitled/models/mobileuser/MobileUser.dart';

class RegisterEmailValidator {
  static Future<String?> validate(String? value) async {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }

    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Format email tidak valid';
    }

    try {
      MobileUser? mobileUser = await MobileUserController.getMobileUserByEmail(value);

      if (mobileUser != null) {
        return 'Email sudah terdaftar';
      }
    } catch (e) {
      return 'Terjadi kesalahan saat memeriksa email. Coba lagi nanti.';
    }

    return null;
  }

  static String? initValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }

    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zAZH0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Format email tidak valid';
    }

    return null;
  }
}

