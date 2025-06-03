import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled/helper/ConfigHelper.dart';
import 'package:untitled/models/error/ErrorResponse.dart';

class ApiHelper {
  static Future<T> get<T>(String endpoint, String? token, T Function(Map<String, dynamic>) fromJson) async {
    final uri = Uri.parse('${ConfigHelper.apiUrl}$endpoint');
    try {
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': '*/*',
        },
      );
      return _tanganiRespons(response, fromJson);
    } catch (e) {
      throw Exception('Kesalahan saat permintaan GET: $e');
    }
  }

  static Future<T> post<T>(String endpoint, String? token, Map<String, dynamic> body, T Function(Map<String, dynamic>) fromJson) async {
    final uri = Uri.parse('${ConfigHelper.apiUrl}$endpoint');
    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': '*/*',
        },
        body: json.encode(body),
      );
      return _tanganiRespons(response, fromJson);
    } catch (e) {
      throw Exception('Kesalahan saat permintaan POST: $e');
    }
  }

  static Future<void> postWithoutFunc(
      String endpoint, String? token, Map<String, dynamic> body) async {
    final uri = Uri.parse('${ConfigHelper.apiUrl}$endpoint');
    try {
      await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': '*/*',
        },
        body: json.encode(body),
      );
    } catch (e) {
      throw Exception('Kesalahan saat permintaan POST: $e');
    }
  }

  static Future<T> put<T>(String endpoint, String? token, Map<String, dynamic> body, T Function(Map<String, dynamic>) fromJson) async {
    final uri = Uri.parse('${ConfigHelper.apiUrl}$endpoint');
    try {
      final response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': '*/*',
        },
        body: json.encode(body),
      );
      return _tanganiRespons(response, fromJson);
    } catch (e) {
      throw Exception('Kesalahan saat permintaan PUT: $e');
    }
  }

  static Future<T> delete<T>(String endpoint, String token, T Function(Map<String, dynamic>) fromJson) async {
    final uri = Uri.parse('${ConfigHelper.apiUrl}$endpoint');
    try {
      final response = await http.delete(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': '*/*',
        },
      );
      return _tanganiRespons(response, fromJson);
    } catch (e) {
      throw Exception('Kesalahan saat permintaan DELETE: $e');
    }
  }

  static Future<T> _tanganiRespons<T>(http.Response response, T Function(Map<String, dynamic>) fromJson) async {
    final responseJson = json.decode(response.body);

    if (responseJson['status'] == 'error' || responseJson['status'] == 'failed') {
      // Jika ada kesalahan, lempar error dengan pesan dari response
      throw ErrorResponse.fromJson(responseJson);
    }

    // Jika tidak ada error, kembalikan objek sesuai tipe yang diinginkan
    return fromJson(responseJson);
  }

}