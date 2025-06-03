import 'package:untitled/helper/TokenHelper.dart';
import 'package:untitled/models/beratbadan/BeratBadan.dart';
import 'package:untitled/models/beratbadan/BeratBadanResponse.dart';
import 'package:untitled/models/beratbadan/BooleanBeratBadanResponse.dart';
import 'package:untitled/models/beratbadan/ListBeratBadanResponse.dart';
import 'package:untitled/services/BeratBadanService.dart';

class BeratBadanController {
  static List<BeratBadan> listBeratBadan = [];

  static Future<List<BeratBadan>?> getAllBeratBadan() async {
    String token = await TokenHelper.getToken();
    try {
      ListBeratBadanResponse response = await BeratBadanService.getAll(token);
      print('Get All Berat Badan Berhasil: ${response.data}');
      return response.data;
    } catch (e) {
      print('Get All Berat Badan Gagal: $e');
    }
  }

  static Future<void> createBeratBadan(int beratLeftPoint, int beratRightPoint) async {
    double beratBadan = beratLeftPoint  + (beratRightPoint / 10);

    String token = await TokenHelper.getToken();
    try {
      BeratBadanResponse response = await BeratBadanService.create(token, beratBadan);
      print('Create Berat Badan Berhasil: ${response.data}');
    } catch (e) {
      print('Create Berat Badan Gagal: $e');
    }
  }

  static Future<void> updateBeratBadan(int idBeratBadan, int beratLeftPoint, int beratRightPoint) async {
    double beratBadan = beratLeftPoint  + (beratRightPoint / 10);

    String token = await TokenHelper.getToken();
    try {
      BeratBadanResponse response = await BeratBadanService.update(token, idBeratBadan, beratBadan);
      print('Update Berat Badan Berhasil: ${response.data}');
    } catch (e) {
      print('Update Berat Badan Gagal: $e');
    }
  }

  static Future<void> deleteBeratBadan(int idBeratBadan) async {
    String token = await TokenHelper.getToken();
    try {
      BooleanBeratBadanResponse response = await BeratBadanService.delete(token, idBeratBadan);
      print('Delete Berat Badan Berhasil: ${response.data}');
    } catch (e) {
      print('Delete Berat Badan Gagal: $e');
    }
  }
}