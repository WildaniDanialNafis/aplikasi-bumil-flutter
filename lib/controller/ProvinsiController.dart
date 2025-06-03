import 'package:untitled/models/provinsi/Provinsi.dart';
import 'package:untitled/models/provinsi/ProvinsiResponse.dart';
import 'package:untitled/services/ProvinsiService.dart';

class ProvinsiController {
  static List<Provinsi> listProvinsi = [];

  static Future<List<Provinsi>> getAllProvinsi() async {
    try {
      ListProvinsiResponse response = await ProvinsiService.getAll();
      print('Get All Provinsi Berhasil: ${response.data}');
      listProvinsi = response.data;
      return response.data ?? [];
    } catch (e) {
      print('Get Provinsi Gagal: $e');
      return [];
    }
  }
}