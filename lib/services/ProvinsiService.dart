import 'package:untitled/helper/ApiHelper.dart';
import 'package:untitled/models/provinsi/ProvinsiResponse.dart';

class ProvinsiService {
  static Future<ListProvinsiResponse> getAll() async {
    try {
      return await ApiHelper.get('/provinces', null, (json) => ListProvinsiResponse.fromJson(json));
    } catch (e) {
      throw Exception('Gagal mengambil data: $e');
    }
  }
}