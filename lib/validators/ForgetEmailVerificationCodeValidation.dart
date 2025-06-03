import 'package:untitled/controller/RegisterController.dart';

class ForgetEmailVerificationCodeValidation {
  static Future<String?> validate(String? value) async {
    if (value == null || value.isEmpty) {
      return 'Kode verifikasi tidak boleh kosong';
    }

    final codeRegex = RegExp(r'^[a-zA-Z0-9]{6}$');
    if (!codeRegex.hasMatch(value)) {
      return 'Kode verifikasi harus terdiri dari 6 karakter alfanumerik';
    }

    try {
      bool isValid = await RegisterController.verifyCode(value);
      if (!isValid) {
        return 'Kode verifikasi tidak valid';
      }
    } catch (e) {
      return 'Terjadi kesalahan saat memeriksa kode: $e';
    }
    return null;
  }

  static String? initValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Kode verifikasi tidak boleh kosong';
    }

    final codeRegex = RegExp(r'^[a-zA-Z0-9]{6}$');
    if (!codeRegex.hasMatch(value)) {
      return 'Kode verifikasi harus terdiri dari 6 karakter alfanumerik';
    }

    return null;
  }
}
