import 'package:untitled/helper/ApiHelper.dart';
import 'package:untitled/models/beratbadan/BeratBadanResponse.dart';
import 'package:untitled/models/beratbadan/BooleanBeratBadanResponse.dart';
import 'package:untitled/models/beratbadan/ListBeratBadanResponse.dart';

class BeratBadanService {

  static Future<ListBeratBadanResponse> getAll(String token) async {
    try {
      return await ApiHelper.get('/api/berat-badan-mobile', token, (json) => ListBeratBadanResponse.fromJson(json));
    } catch (e) {
      throw Exception('Gagal mengambil data: $e');
    }
  }

  static Future<BeratBadanResponse> create(String token, double beratBadan) async {
    try {
      return await ApiHelper.post('/api/berat-badan/add', token, {
        'beratBadan': beratBadan,
      }, (json) => BeratBadanResponse.fromJson(json));
    } catch (e) {
      throw Exception('Gagal membuat data: $e');
    }
  }

  static Future<BeratBadanResponse> update(String token, int idBeratBadan, double beratBadan) async {
    try {
      return await ApiHelper.put('/api/berat-badan/edit/$idBeratBadan', token, {
        'beratBadan': beratBadan,
      }, (json) => BeratBadanResponse.fromJson(json));
    } catch (e) {
      throw Exception('Gagal memperbarui data: $e');
    }
  }

  static Future<BooleanBeratBadanResponse> delete(String token, int idBeratBadan) async {
    try {
      return await ApiHelper.delete('/api/berat-badan/delete/$idBeratBadan', token, (json) => BooleanBeratBadanResponse.fromJson(json));
    } catch (e) {
      throw Exception('Gagal menghapus data: $e');
    }
  }
}