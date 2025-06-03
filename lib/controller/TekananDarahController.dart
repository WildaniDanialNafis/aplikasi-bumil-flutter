import 'package:untitled/helper/TokenHelper.dart';
import 'package:untitled/models/tekanandarah/BooleanTekananDarah.dart';
import 'package:untitled/models/tekanandarah/ListTekananDarahResponse.dart';
import 'package:untitled/models/tekanandarah/TekananDarah.dart';
import 'package:untitled/models/tekanandarah/TekananDarahResponse.dart';
import 'package:untitled/services/TekananDarahService.dart';

class TekananDarahController {
  static List<TekananDarah> listTekananDarah = [];

  static Future<List<TekananDarah>?> getAllTekananDarah() async {
    String token = await TokenHelper.getToken();
    try {
      ListTekananDarahResponse response = await TekananDarahService.getAll(token);
      print('Get All Tekanan Darah Berhasil: ${response.data}');
      return response.data;
    } catch (e) {
      print('Get All Tekanan Darah Gagal: $e');
    }
  }

  static Future<void> createTekananDarah(int sistolik, int diastolik) async {
    String token = await TokenHelper.getToken();
    try {
      TekananDarahResponse response = await TekananDarahService.create(token, sistolik, diastolik);
      print('Create Tekanan Darah Berhasil: ${response.data}');
    } catch (e) {
      print('Create Tekanan Darah Gagal: $e');
    }
  }

  static Future<void> updateTekananDarah(int idTekananDarah, int sistolik, int diastolik) async {
    String token = await TokenHelper.getToken();
    try {
      TekananDarahResponse response = await TekananDarahService.update(token, idTekananDarah, sistolik, diastolik);
      print('Update Tekanan Darah Berhasil: ${response.data}');
    } catch (e) {
      print('Update Tekanan Darah Gagal: $e');
    }
  }

  static Future<void> deleteTekananDarah(int idTekananDarah) async {
    String token = await TokenHelper.getToken();
    try {
      BooleanTekananDarahResponse response = await TekananDarahService.delete(token, idTekananDarah);
      print('Delete Berat Badan Berhasil: ${response.data}');
    } catch (e) {
      print('Delete Berat Badan Gagal: $e');
    }
  }
}