import 'package:untitled/helper/ApiHelper.dart';
import 'package:untitled/models/hpl/BooleanHplResponse.dart';
import 'package:untitled/models/hpl/HplResponse.dart';
import 'package:untitled/models/hpl/ListHplResponse.dart';

class HplService {

  static Future<HplResponse> get(String token) async {
    try {
      return await ApiHelper.get('/api/hpl-mobile', token, (json) => HplResponse.fromJson(json));
    }  catch (e) {
      throw Exception('Gagal mengambil data: $e');
    }
  }

  static Future<HplResponse> createByDate(String token, String hpl) async {
    try {
      return await ApiHelper.post('/api/hpl-date/add', token, {
        'hpl': hpl
      }, (json) => HplResponse.fromJson(json));
    } catch (e) {
      throw Exception('Gagal membuat data: $e');
    }
  }

  static Future<HplResponse> createByUsia(String token, int usiaMinggu, int usiaHari) async {
    try {
      return await ApiHelper.post('/api/hpl-usia/add', token, {
        'usiaMinggu': usiaMinggu,
        'usiaHari': usiaHari
      }, (json) => HplResponse.fromJson(json));
    } catch (e) {
      throw Exception('Gagal membuat data: $e');
    }
  }

  static Future<HplResponse> updateByDate(String token, int idHpl, String hpl) async {
    try {
      return await ApiHelper.put('/api/hpl-date/edit/$idHpl', token, {
        'hpl': hpl
      }, (json) => HplResponse.fromJson(json));
    } catch (e) {
      throw Exception('Gagal memperbarui data: $e');
    }
  }

  static Future<HplResponse> updateByUsia(String token, int idHpl, int usiaMinggu, int usiaHari) async {
    try {
      return await ApiHelper.put('/api/hpl-usia/edit/$idHpl', token, {
        'usiaMinggu': usiaMinggu,
        'usiaHari': usiaHari
      }, (json) => HplResponse.fromJson(json));
    } catch (e) {
      throw Exception('Gagal memperbarui data: $e');
    }
  }

  static Future<BooleanHplResponse> delete(String token, int idHpl) async {
    try {
      return await ApiHelper.delete('/api/hpl/delete/$idHpl', token, (json) => BooleanHplResponse.fromJson(json));
    } catch (e) {
      throw Exception('Gagal menghapus data: $e');
    }
  }
}