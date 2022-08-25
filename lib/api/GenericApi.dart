import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:youplay/config/app_config.dart';

abstract class JsonSerializable {
  Map toJson();
}

class GenericApi {
  static String apiUrl = AppConfig().baseUrl;

  static Future<String> getIdToken() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return '';
    }
     // String t = await user.getIdToken(true);
     // print('token is $t');
    return await user.getIdToken();
  }

  Future<http.Response> getNew(String path) async {
    return http.get(
        Uri.https(AppConfig().baseUrl, path),
        headers: {"Authorization": "Bearer " + await getIdToken()});
  }

  static Future<Response> get(String path, [Map<String, dynamic>? queryParameters]) async {
    var url = Uri.https(AppConfig().baseUrl, path, queryParameters);
    return await http.get(url,
        headers: {"Authorization": "Bearer " + await GenericApi.getIdToken()});
  }

  static Future<Response> getUnAuth(String path, [Map<String, dynamic>? queryParameters]) async {
    var url = Uri.https(AppConfig().baseUrl, path, queryParameters);
    return await http.get(url);
  }

  static Future<Response> post(String path, Object? value) async {
    var url = Uri.https(AppConfig().baseUrl, path);
    return await http.post(url,
        headers: {"Authorization": "Bearer " + await GenericApi.getIdToken()},
        body: json.encode(value)
    );
  }

  static Future<Response> delete(String path) async {
    var url = Uri.https(AppConfig().baseUrl, path);
    return await http.delete(url,
        headers: {"Authorization": "Bearer " + await GenericApi.getIdToken()});
  }
}