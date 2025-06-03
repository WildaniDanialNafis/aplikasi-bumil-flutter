import 'package:untitled/models/kabupaten/Kabupaten.dart';
import 'package:untitled/models/kabupaten/KabupatenResponse.dart';
import 'package:untitled/services/KabupatenService.dart';

class KabupatenController {
  static List<Kabupaten> listKabupaten = [];

  static Future<List<Kabupaten>> getAllKabupaten(String provinsiId) async {
    try {
      ListKabupatenResponse response = await KabupatenService.getAll(provinsiId);
      print('Get All Kabupaten Berhasil: ${response.data}');
      listKabupaten = response.data;
      return response.data ?? [];
    } catch (e) {
      print('Get All Kabupaten Gagal: $e');
      return [];
    }
  }
}