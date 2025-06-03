import 'package:untitled/helper/TokenHelper.dart';
import 'package:untitled/models/mobileuser/BooleanMobileUserResponse.dart';
import 'package:untitled/models/mobileuser/MobileUser.dart';
import 'package:untitled/models/mobileuser/MobileUserResponse.dart';
import 'package:untitled/services/MobileUserService.dart';

class MobileUserController {
  static MobileUser? mobileUser = null;

  static Future<MobileUser?> getMobileUser() async {
    String token = await TokenHelper.getToken();
    try {
      MobileUserResponse response = await MobileUserService.get(token);
      print('Get Mobile User Berhasil: ${response.data}');
      mobileUser = response.data;
      return response.data;
    } catch (e) {
      print('Get Mobile User Gagal: $e');
      return null;
    }
  }

  static Future<MobileUser?> getMobileUserByEmail(String email) async {
    try {
      MobileUserResponse response = await MobileUserService.getByEmail(email);
      print('Get Mobile User By Email Berhasil: ${response.data}');
      return response.data;
    } catch (e) {
      print('Get Mobile User By Email Gagal: $e');
      return null;
    }
  }

  static Future<MobileUser?> createMobileUser(String email, String password) async {
    try {
      MobileUserResponse response = await MobileUserService.create(email, password);
      print('Create Mobile User Berhasil: ${response.data}');
      return response.data;
    } catch (e) {
      print('Create Mobile User Gagal: $e');
    }
  }

  static Future<void> updateMobileUser(int idMobileUser, String email, String password) async {
    try {
      MobileUserResponse response = await MobileUserService.update(idMobileUser, email, password);
      print('Update Mobile User Berhasil: ${response.data}');
    } catch (e) {
      print('Update Mobile User Gagal: $e');
    }
  }

  static Future<void> deleteMobileUser(int idMobileUser) async {
    String token = await TokenHelper.getToken();
    try {
      BooleanMobileUserResponse response = await MobileUserService.delete(token, idMobileUser);
      print('Delete Mobile User Berhasil: ${response.data}');
    } catch (e) {
      print('Delete Mobile User Gagal: $e');
    }
  }
}