import 'package:flutter/cupertino.dart';
import 'package:untitled/components/alert/CustomAlertDialog.dart';
import 'package:untitled/helper/TokenHelper.dart';
import 'package:untitled/models/datadiri/BooleanDataDiriResponse.dart';
import 'package:untitled/models/datadiri/DataDiri.dart';
import 'package:untitled/models/datadiri/DataDiriResponse.dart';
import 'package:untitled/models/datadiri/ListDataDiriResponse.dart';
import 'package:untitled/services/DataDiriService.dart';

class DataDiriController {
  static DataDiri? dataDiri = null;

  static Future<DataDiri?> getAllDataDiri() async {
    String token = await TokenHelper.getToken();
    try {
      ListDataDiriResponse response = await DataDiriService.getAll(token);
      print('Get All Data Diri Berhasil: ${response.data}');
      if (response.data.isNotEmpty) {
        dataDiri = response.data[0];
      }
      return response.data[0];
    } catch (e) {
      print('Get All Data Diri Gagal: $e');
    }
  }

  static Future<void> createDataDiri(String namaLengkap, String tempatLahir, String tanggalLahir, String jenisKelamin, String provinsi, String kabupaten, String alamat, String nomorTelepon) async {
    String token = await TokenHelper.getToken();
    try {
      DataDiriResponse response = await DataDiriService.create(token, namaLengkap, tempatLahir, tanggalLahir, jenisKelamin, provinsi, kabupaten, alamat, nomorTelepon);
      print('Create Data Diri Berhasil: ${response.data}');
    } catch (e) {
      print('Create Data Diri Gagal: $e');
    }
  }

  static Future<void> createDataDiriReg(String namaLengkap, String tempatLahir, String tanggalLahir, String jenisKelamin, String provinsi, String kabupaten, String alamat, String nomorTelepon, int mobileUserId) async {
    try {
      DataDiriResponse response = await DataDiriService.createReg(namaLengkap, tempatLahir, tanggalLahir, jenisKelamin, provinsi, kabupaten, alamat, nomorTelepon, mobileUserId);
      print('Create Data Diri Berhasil: ${response.data}');
    } catch (e) {
      print('Create Data Diri Gagal: $e');
    }
  }

  static Future<void> updateDataDiri(int idDataDiri, String namaLengkap, String tempatLahir, String tanggalLahir, String jenisKelamin, String provinsi, String kabupaten, String alamat, String nomorTelepon) async {
    String token = await TokenHelper.getToken();
    try {
      DataDiriResponse response = await DataDiriService.update(token, idDataDiri, namaLengkap, tempatLahir, tanggalLahir, jenisKelamin, provinsi, kabupaten, alamat, nomorTelepon);
      print('Update Data Diri Berhasil: ${response.data}');
    } catch (e) {
      print('Update Data Diri Gagal: $e');
    }
  }

  static Future<void> deleteDataDiri(int idDataDiri) async {
    String token = await TokenHelper.getToken();
    try {
      BooleanDataDiriResponse response = await DataDiriService.delete(token, idDataDiri);
      print('Delete Data Diri Berhasil: ${response.data}');
    } catch (e) {
      print('Delete Data Diri Gagal: $e');
    }
  }
}