import 'package:untitled/controller/MobileUserController.dart';
import 'package:untitled/models/login/LoginResponse.dart';
import 'package:untitled/services/LoginService.dart';
import '../models/mobileuser/MobileUser.dart';

class LoginValidator {
  static String? initValidateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }

    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Format email tidak valid';
    }

    return null;
  }

  static String? initValidatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 8) {
      return 'Password harus minimal 8 karakter';
    }
    return null;
  }

  static Future<String?> validateEmail(String? value) async {
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
    } catch (e) {
      return 'Gagal memverifikasi email: $e';
    }

    return null;
  }

  static Future<String?> validateLoginForm(String email, String password) async {
    String? emailValidation = await validateEmail(email);
    if (emailValidation != null) {
      return emailValidation;
    }

    String? passwordValidation = initValidatePassword(password);
    if (passwordValidation != null) {
      return passwordValidation;
    }

    try {
      await LoginService.login(email, password);
    } catch (e) {
      return 'Email atau password salah';
    }

    return null;
  }
}
