import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  // static final _clientIDWeb = '128111418178-ur22j4jb7sifc6q0eiq5g0rd8k4gglrg.apps.googleusercontent.com';

  static final _clientIDWeb = '593838745231-j40aaju1ldsslociflofqkos3nq88crq.apps.googleusercontent.com';

  static final _googleSignIn = GoogleSignIn(clientId: _clientIDWeb);

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  static Future logout() => _googleSignIn.disconnect();
}