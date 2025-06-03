import 'package:untitled/helper/TokenHelper.dart';
import 'package:untitled/models/hpl/BooleanHplResponse.dart';
import 'package:untitled/models/hpl/Hpl.dart';
import 'package:untitled/models/hpl/HplResponse.dart';
import 'package:untitled/services/HplService.dart';

class HplController {
  static Hpl? hpl = null;

  static Future<Hpl?> getHpl() async {
    String token = await TokenHelper.getToken();

    try {
      HplResponse response = await HplService.get(token);
      print('Get HPL Berhasil: ${response.data}');
      hpl = response.data;
      return response.data;
    } catch (e) {
      print('Get HPL Gagal: $e');
      return null;
    }
  }

  static Future<void> createHplByDate(String hpl) async {
    String token = await TokenHelper.getToken();

    try {
      HplResponse response = await HplService.createByDate(token, hpl);
      print('Create By Date HPL Berhasil: ${response.data}');
    } catch (e) {
      print('Create By Date HPL Gagal: $e');
    }
  }

  static Future<void> createHplByUsia(int usiaMinggu, int usiaHari) async {
    String token = await TokenHelper.getToken();

    try {
      HplResponse response = await HplService.createByUsia(token, usiaMinggu, usiaHari);
      print('Create By Usia HPL Berhasil: ${response.data}');
    } catch (e) {
      print('Create By Usia HPL Gagal: $e');
    }
  }

  static Future<void> updateHplByDate(int idHpl, String hpl) async {
    String token = await TokenHelper.getToken();

    try {
      HplResponse response = await HplService.updateByDate(token, idHpl, hpl);
      print('Update By Date HPL Berhasil: ${response.data}');
    } catch (e) {
      print('Update By Date HPL Gagal: $e');
    }
  }

  static Future<void> updateHplByUsia(int idHpl, int usiaMinggu, int usiaHari) async {
    String token = await TokenHelper.getToken();

    try {
      HplResponse response = await HplService.updateByUsia(token, idHpl, usiaMinggu, usiaHari);
      print('Update By Usia HPL Berhasil: ${response.data}');
    } catch (e) {
      print('Update By Usia HPL Gagal: $e');
    }
  }

  static Future<void> deleteHpl(int idHpl) async {
    String token = await TokenHelper.getToken();

    try {
      BooleanHplResponse response = await HplService.delete(token, idHpl);
      print('Delete HPL Berhasil: ${response.data}');
    } catch (e) {
      print('Delete HPL Gagal: $e');
    }
  }
}