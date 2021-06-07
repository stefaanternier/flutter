import 'package:youplay/config/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youplay/models/account.dart';
import 'dart:convert';

class AccountApi {
  static String apiUrl = AppConfig().baseUrl;

  static Future<String> getIdToken() async {
    User user = FirebaseAuth.instance.currentUser;
    String token = await user.getIdToken(true);
    return token;
  }

  static Future<dynamic> accountDetails() async {
    var url = Uri.https(AppConfig().baseUrl, 'api/account/accountDetails');
    final response = await http.get(url,
        headers: {"Authorization": "Bearer " + await getIdToken()});
//    print(response.body);
    return response.body;
  }

  static Future<dynamic> eraseAnonAcount() async {
    var url = Uri.https(AppConfig().baseUrl, 'api/account/eraseAnonAccount');
    final response = await http.delete(url,
        headers: {"Authorization": "Bearer " + await getIdToken()});
//    print(response.body);
    return response.body;
  }

  static Future<dynamic> initNewAccount(String email, String displayName) async {
    var url = Uri.https(AppConfig().baseUrl, 'api/account/update/displayName/asUser');
    Account acc = new Account(name: displayName, email: email);
    final response = await http.post(url,
        headers: {"Authorization": "Bearer " + await getIdToken()},
        body: json.encode(acc.toJson()));

    return response.body;
  }
}
