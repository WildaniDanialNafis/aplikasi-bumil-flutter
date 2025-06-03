import 'package:untitled/helper/ApiHelper.dart';
import 'package:untitled/models/datadiri/BooleanDataDiriResponse.dart';
import 'package:untitled/models/datadiri/DataDiriResponse.dart';
import 'package:untitled/models/datadiri/ListDataDiriResponse.dart';

class DataDiriService {

  static Future<ListDataDiriResponse> getAll(String token) async {
    try {
      return await ApiHelper.get('/api/data-diri-mobile', token, (json) => ListDataDiriResponse.fromJson(json));
    } catch (e) {
      throw Exception('Gagal mengambil data: $e');
    }
  }

  static Future<DataDiriResponse> create(String token, String namaLengkap, String tempatLahir, String tanggalLahir, String jenisKelamin, String provinsi, String kabupaten, String alamat, String nomorTelepon) async {
    try {
      return await ApiHelper.post('/api/data-diri-mobile/add', token, {
        'namaLengkap': namaLengkap,
        'tempatLahir': tempatLahir,
        'tanggalLahir': tanggalLahir,
        'jenisKelamin': jenisKelamin,
        'provinsi': provinsi,
        'kabupaten': kabupaten,
        'alamat': alamat,
        'nomorTelepon': nomorTelepon
      }, (json) => DataDiriResponse.fromJson(json));
    } catch (e) {
      throw Exception('Gagal membuat data: $e');
    }
  }

  static Future<DataDiriResponse> createReg(String namaLengkap, String tempatLahir, String tanggalLahir, String jenisKelamin, String provinsi, String kabupaten, String alamat, String nomorTelepon, int mobileUserId) async {
    try {
      return await ApiHelper.post('/huhu/add', null, {
        'namaLengkap': namaLengkap,
        'tempatLahir': tempatLahir,
        'tanggalLahir': tanggalLahir,
        'jenisKelamin': jenisKelamin,
        'provinsi': provinsi,
        'kabupaten': kabupaten,
        'alamat': alamat,
        'nomorTelepon': nomorTelepon,
        'mobileUserId': mobileUserId
      }, (json) => DataDiriResponse.fromJson(json));
    } catch (e) {
      throw Exception('Gagal membuat data: $e');
    }
  }

  static Future<DataDiriResponse> update(String token, int idDataDiri, String namaLengkap, String tempatLahir, String tanggalLahir, String jenisKelamin, String provinsi, String kabupaten, String alamat, String nomorTelepon) async {
    try {
      return await ApiHelper.put('/api/data-diri-mobile/edit/${idDataDiri}', token, {
        'namaLengkap': namaLengkap,
        'tempatLahir': tempatLahir,
        'tanggalLahir': tanggalLahir,
        'jenisKelamin': jenisKelamin,
        'provinsi': provinsi,
        'kabupaten': kabupaten,
        'alamat': alamat,
        'nomorTelepon': nomorTelepon
      }, (json) => DataDiriResponse.fromJson(json));
    } catch (e) {
      throw Exception('Gagal memperbarui data: $e');
    }
  }

  static Future<BooleanDataDiriResponse> delete(String token, int idDataDiri) async {
    try {
      return await ApiHelper.delete('/api/data-diri-mobile/delete/${idDataDiri}', token, (json) => BooleanDataDiriResponse.fromJson(json));
    } catch (e) {
      throw Exception('Gagal menghapus data: $e');
    }
  }
}