import 'package:untitled/helper/ApiHelper.dart';
import 'package:untitled/helper/EmailHelper.dart';
import 'package:untitled/models/register/EmailCodeResponse.dart';
import 'package:untitled/models/register/EmailVerificationResponse.dart';

class RegisterService {
  static Future<EmailCodeResponse> createCode(String email) async {
    try {
      return await ApiHelper.post('/send-email', null, {
        'email': email
      }, (json) => EmailCodeResponse.fromJson(json));
    } catch (e) {
      return throw Exception('Gagal membuat code: $e');
    }
  }

  static Future<EmailVerificationResponse> verify(String code) async {

    String email = await EmailHelper.getEmail();
    print(email);
    print(code);
    try {
      return await ApiHelper.post('/verify-code', null, {
        'email': email,
        'code': code,
      }, (json) => EmailVerificationResponse.fromJson(json));
    } catch (e) {
        throw Exception('Gagal verifikasi code: $e');
    }
  }
}