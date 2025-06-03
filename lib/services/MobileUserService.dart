import 'package:untitled/helper/ApiHelper.dart';
import 'package:untitled/models/mobileuser/BooleanMobileUserResponse.dart';
import 'package:untitled/models/mobileuser/MobileUserResponse.dart';

class MobileUserService {

  static Future<MobileUserResponse> get(String token) async {
    try {
      return await ApiHelper.get('/api/mobile-users-mobile', token, (json) => MobileUserResponse.fromJson(json));
    } catch (e) {
      throw Exception('Gagal mengambil data: $e');
    }
  }

  static Future<MobileUserResponse> getByEmail(String email) async {
    try {
      return await ApiHelper.post('/api/mobile-users-email', null, {
        "email": email
      }, (json) => MobileUserResponse.fromJson(json));
    } catch (e) {
      throw Exception('Gagal mengambil data: $e');
    }
  }

  static Future<MobileUserResponse> create(String email, String password) async {
    try {
      return await ApiHelper.post('/api/mobile-users-mobile/add', null, {
        'email': email,
        'password': password
      }, (json) => MobileUserResponse.fromJson(json));
    } catch (e) {
      throw Exception('Gagal membuat data: $e');
    }
  }

  static Future<MobileUserResponse> update(int idMobileUser, String email, String password) async {
    try {
      return await ApiHelper.put('/api/mobile-users/edit/$idMobileUser', null, {
        'email': email,
        'password': password
      }, (json) => MobileUserResponse.fromJson(json));
    } catch (e) {
      throw Exception('Gagal memperbarui data: $e');
    }
  }

  static Future<MobileUserResponse> updateToken(int idMobileUser) async {
    try {
      return await ApiHelper.put('/api/mobile-users/edit-token/$idMobileUser', null, {
        'token': null
      }, (json) => MobileUserResponse.fromJson(json));
    } catch (e) {
      throw Exception('Gagal memperbarui data: $e');
    }
  }

  static Future<BooleanMobileUserResponse> delete(String token, int idMobileUser) async {
    try {
      return await ApiHelper.delete('/api/mobile-users/delete/$idMobileUser', token, (json) => BooleanMobileUserResponse.fromJson(json));
    } catch (e) {
      throw Exception('Gagal menghapus data: $e');
    }
  }
}