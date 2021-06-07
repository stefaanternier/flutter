import 'package:youplay/config/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class UsersApi {
  static Future<String> getIdToken() async {
    User user = FirebaseAuth.instance.currentUser;
    String token = await user.getIdToken(true);
    return token;
  }

  static Future<dynamic> runUsers() async {
    var url = Uri.https(AppConfig().baseUrl, 'api/run/users');
    final response = await http.get(
        url, headers:{"Authorization":"Bearer "+await getIdToken()});
    return response.body;
  }
}
