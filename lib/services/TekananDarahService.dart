import 'package:untitled/helper/ApiHelper.dart';
import 'package:untitled/models/tekanandarah/BooleanTekananDarah.dart';
import 'package:untitled/models/tekanandarah/ListTekananDarahResponse.dart';
import 'package:untitled/models/tekanandarah/TekananDarahResponse.dart';

class TekananDarahService {

  static Future<ListTekananDarahResponse> getAll(String token) async {
    try {
      return await ApiHelper.get('/api/tekanan-darah-mobile', token, (json) => ListTekananDarahResponse.fromJson(json));
    } catch (e) {
      throw Exception('Gagal mengambil data: $e');
    }
  }

  static Future<TekananDarahResponse> create(String token, int sistolik, int diastolik) async {
    try {
      return await ApiHelper.post('/api/tekanan-darah/add', token, {
        'sistolik': sistolik,
        'diastolik': diastolik
      }, (json) => TekananDarahResponse.fromJson(json));
    } catch (e) {
      throw Exception('Gagal membuat data: $e');
    }
  }

  static Future<TekananDarahResponse> update(String token, int idTekananDarah, int sistolik, int diastolik) async {
    try {
      return await ApiHelper.put('/api/tekanan-darah/edit/$idTekananDarah', token, {
        'sistolik': sistolik,
        'diastolik': diastolik
      }, (json) => TekananDarahResponse.fromJson(json));
    } catch (e) {
      throw Exception('Gagal memperbarui data: $e');
    }
  }

  static Future<BooleanTekananDarahResponse> delete(String token, int idTekananDarah) async {
    try {
      return await ApiHelper.delete('/api/tekanan-darah/delete/$idTekananDarah', token, (json) => BooleanTekananDarahResponse.fromJson(json));
    } catch (e) {
      throw Exception('Gagal menghapus data: $e');
    }
  }
}