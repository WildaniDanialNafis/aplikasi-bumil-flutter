import 'package:untitled/helper/ApiHelper.dart';
import 'package:untitled/models/kabupaten/KabupatenResponse.dart';

class KabupatenService {
  static Future<ListKabupatenResponse> getAll(String provinsiId) async {
    print(provinsiId);
    try {
      return await ApiHelper.get('/kabupatens/${provinsiId}', null, (json) => ListKabupatenResponse.fromJson(json));
    } catch (e) {
      throw Exception('Gagal mengambil data: $e');
    }
  }
}