import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cryptomask_admin/config.dart';
import 'package:cryptomask_admin/service/remote/model/app_settings_response.dart';
import 'package:cryptomask_admin/service/remote/model/message.dart';
import 'package:cryptomask_admin/service/remote/model/token.dart';
import 'package:cryptomask_admin/service/remote/model/user.dart';
import 'package:dio/dio.dart';

final http = Dio(BaseOptions(
  baseUrl: baseUrlAdmin,
));

class RemoteService {
  static Future<String> login(String username, String password) async {
    final response = await http.post('/login',
        data: jsonEncode({'username': username, 'password': password}),
        options: Options(headers: {'content-type': 'application/json'}));
    return response.data['data'];
  }

  static Future<List<User>> getUser(String token) async {
    final response = await http.get('/users',
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    return response.data['data']
        .map<User>((user) => User.fromJson(user))
        .toList();
  }

  static Future<List<Token>> getWalletHoldings(
      String token, String address, int chain) async {
    final response = await http.get('/tokens/$address/$chain',
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    return response.data['data']
        .map<Token>((token) => Token.fromJson(token))
        .toList();
  }

  static Future<void> deactivateUser(String token, int userId) async {
    await http.get('/users/deactivate/$userId',
        options: Options(headers: {'Authorization': 'Bearer $token'}));
  }

  static Future<void> activateUser(String token, int userId) async {
    await http.get('/users/activate/$userId',
        options: Options(headers: {'Authorization': 'Bearer $token'}));
  }

  static Future<AppSettingsResponse> appSettings(String token) async {
    final response = await http.get('/settings',
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    return AppSettingsResponse.fromJson(response.data);
  }

  static Future<AppSettingsResponse> updateAppSettings(
      String token, AppSettings appSettings) async {
    final response = await http.patch('/settings',
        data: appSettings.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    return AppSettingsResponse.fromJson(response.data);
  }

  static Future<void> block(String token, int userId) async {
    await http.get('/users/block/$userId',
        options: Options(headers: {'Authorization': 'Bearer $token'}));
  }

  static Future<void> unblock(String token, int userId) async {
    await http.get('/users/unblock/$userId',
        options: Options(headers: {'Authorization': 'Bearer $token'}));
  }

  static Future<Media?> uploadFile(
      String token, File file, String fileName) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path, filename: fileName)
      });
      var response = await http.post("/upload",
          data: formData,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      final media = Media.fromJson(response.data['data']);
      return media;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
