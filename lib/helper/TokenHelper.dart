import 'package:shared_preferences/shared_preferences.dart';

class TokenHelper {

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null || token.isEmpty) {
      throw Exception('Token tidak tersedia');
    }
    return token;
  }
}
