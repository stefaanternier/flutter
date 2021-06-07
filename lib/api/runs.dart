import 'dart:convert';

import 'package:youplay/config/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youplay/models/run.dart';

class RunsApi {

  static Future<String> getIdToken() async {
    User user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return '';
    }
    String token = await user.getIdToken(true);
    return token;
  }

  static Future<List<Run>> participate(int gameId) async {
    var url = Uri.https(AppConfig().baseUrl, 'api/runs/participate/$gameId');
    final response = await http.get(url,
        headers: {"Authorization": "Bearer " + await getIdToken()});
//    print("body participate ${response.body}");
    Map<String, dynamic> runMap = jsonDecode(response.body);
    if (runMap["runs"] == null) return [];
    return (runMap["runs"] as List).map((json) => Run.fromJson(json)).toList(growable: false);
//    return response.body;
  }

  static Future<dynamic> runWithGame(int runId) async {
    var url = Uri.https(AppConfig().baseUrl, 'api/run/$runId/unauth');
    final response = await http.get(url ,
        headers: {"Authorization": "Bearer " + await getIdToken()});
//    print("body runWithGame ${response.body}");
//     Map<String, dynamic> gameMap = jsonDecode(response.body);
    if (response.statusCode == 401) {
      final response = await http.get(url);
      if (response.statusCode == 401) {
        return null;
      }
      return jsonDecode(response.body);

    }
    return jsonDecode(response.body);
  }

  static Future<dynamic> addMeToRun(int runId) async {
    var url = Uri.https(AppConfig().baseUrl, 'api/run/$runId/addMe');
    final response = await http.get(url ,
        headers: {"Authorization": "Bearer " + await getIdToken()});
    return response.body;
  }

  static Future<dynamic> gameFromRun(int gameId) async {
    var url = Uri.https(AppConfig().baseUrl, 'api/runs/game/$gameId');
    final response = await http.get(url,
        headers: {"Authorization": "Bearer " + await getIdToken()});
//    print("body gameFromRun ${response.body}");
    return response.body;
  }

  static Future<Run> requestRun(gameId, String name) async {
    var url = Uri.https(AppConfig().baseUrl, 'api/run/create/withSelf');
    Run run = new Run(gameId: gameId, title: name);
    final httpResponse = await http.post(url,
        headers: {"Authorization": "Bearer " + await getIdToken()},
        body: json.encode(run.toJson())
    );
//    print('response from server ${httpResponse.body}');
    return Run.fromJson(jsonDecode(httpResponse.body));

  }


  static Future<Run> registerToRun(runId) async {
    var url = Uri.https(AppConfig().baseUrl,  'api/run/$runId/addMe');
    final httpResponse = await http.get(url,
        headers: {"Authorization": "Bearer " + await getIdToken()}
    );

    return Run.fromJson(jsonDecode(httpResponse.body));

  }
}
