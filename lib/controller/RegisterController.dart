import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/controller/LoginController.dart';
import 'package:untitled/helper/EmailHelper.dart';
import 'package:untitled/models/mobileuser/MobileUserResponse.dart';
import 'package:untitled/models/register/EmailCodeResponse.dart';
import 'package:untitled/services/MobileUserService.dart';
import 'package:untitled/services/RegisterService.dart';

class RegisterController {
  static Future<void> register(String email, String password, BuildContext context) async {
    try {
      MobileUserResponse response = await MobileUserService.create(email, password);
      print('Create Mobile User Berhasil: ${response.data}');
      LoginController.login(email, password, context);
    } catch (e) {
      print('Create Mobile User Gagal: $e');
    }
  }

  static Future<void> verifyEmail(String email) async {
    try {
      EmailCodeResponse response =  await RegisterService.createCode(email);
      print('Code: ${response.data.kode}');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
      await prefs.setString('kode_verif', response.data.kode);
      print('Verify Email Berhasil');
    } catch (e) {
      print('Verify Email Gagal: $e');
    }
  }

  static Future<bool> verifyCode(String code) async {
    String kode = await EmailHelper.getKode();
    try {
      if (kode == code) {
        print('Verify Code Berhasil');
        return true;
      } else {
        print('Kode tidak valid');
        return false;
      }
    } catch (e) {
      print('Verify Code Gagal: $e');
      throw Exception('Terjadi kesalahan dalam verifikasi kode');
    }
  }

}