import 'package:flutter/material.dart';
import 'package:untitled/components/navigationBar/CustomNavigationBar.dart';
import 'package:untitled/screens/dashboardScreen/DashboardScreen.dart';
import 'package:untitled/services/LoginService.dart';
import 'package:untitled/models/login/LoginResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  static Future<void> login(String email, String password, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('email');
      await prefs.remove('kode_verif');
      await prefs.remove('idMobileUser');
      LoginResponse response = await LoginService.login(email, password);
      await prefs.setString('token', response.data.token);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => CustomNavigationBar(),
      ));
    } catch (e) {
      print('Login gagal: $e');
    }
  }
}