import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:youplay/config/app_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GenericApi {
  static String apiUrl = AppConfig().baseUrl;

  static Future<String> getIdToken() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return '';
    }
     // String t = await user.getIdToken(true);
     // print('token is $t');
    return await user.getIdToken(true);
  }

  static Future<Response> get(String path) async {
    var url = Uri.https(AppConfig().baseUrl, path);
    return await http.get(url,
        headers: {"Authorization": "Bearer " + await GenericApi.getIdToken()});
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