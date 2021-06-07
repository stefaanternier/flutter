import 'package:youplay/config/app_config.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';

class GeneralItemsApi {
  static   String apiUrl = AppConfig().baseUrl;

  static Future<String> getIdToken() async {
    User user = FirebaseAuth.instance.currentUser;
    String token = await user.getIdToken(true);
    return token;
  }

  static Future<dynamic> visibleItems(int runId) async {
    var url = Uri.https(AppConfig().baseUrl, 'api/generalItems/visible/runId/$runId');
    final response = await http.get(
        url, headers:{"Authorization":"Bearer "+await getIdToken()});

    print ('visible items ${response.body}');
    return response.body;
  }

  static Future<dynamic> generalItems(int gameId) async {
    var url = Uri.https(AppConfig().baseUrl, 'api/generalItems/gameId/${gameId}');
    final response = await http.get(
        url, headers:{"Authorization":"Bearer "+await getIdToken()});
    return response.body;
  }

  static Future<dynamic> generalItemsWithCursor(int gameId, String cursor) async {
    var url = Uri.https(AppConfig().baseUrl, 'api/generalItems/gameId/$gameId/cursor/$cursor');
    if (cursor == null) {
      cursor = '*';
    }
    final response = await http.get(
        url, headers:{"Authorization":"Bearer "+await getIdToken()});
    return response.body;
  }
}
