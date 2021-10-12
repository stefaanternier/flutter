import 'dart:convert';

import 'package:youplay/config/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youplay/models/run.dart';

import 'GenericApi.dart';

class RunsApi extends GenericApi {

  static Future<List<Run>> participate(int gameId) async {
    final response = await GenericApi.get('api/runs/participate/$gameId');
    Map<String, dynamic> runMap = jsonDecode(response.body);
    if (runMap["runs"] == null) return [];
    return (runMap["runs"] as List).map((json) => Run.fromJson(json)).toList(growable: false);
  }

  static Future<dynamic> runWithGame(int runId) async {
    final response = await GenericApi.get('api/run/$runId/unauth');

    if (response.statusCode == 401) {
      final response = await http.get(Uri.https(AppConfig().baseUrl, 'api/run/$runId/unauth'));
      if (response.statusCode == 401) {
        return null;
      }
      return jsonDecode(response.body);
    }
    return jsonDecode(response.body);
  }

  static Future<dynamic> addMeToRun(int runId) async {
    final response = await GenericApi.get('api/run/$runId/addMe');
    return response.body;
  }

  static Future<dynamic> gameFromRun(int gameId) async {
    final response = await GenericApi.get('api/runs/game/$gameId');
    return response.body;
  }

  static Future<Run> requestRun(gameId, String name) async {
    Run run = new Run(gameId: gameId, title: name, lastModificationDate: DateTime.now().millisecondsSinceEpoch);
    final response = await GenericApi.post(
        'api/run/create/withSelf',
        run.toJson()
    );
    print ('response ${response.body}');
    return Run.fromJson(jsonDecode(response.body));
  }

  static Future<Run> registerToRun(runId) async {
    final response = await GenericApi.get('api/run/$runId/addMe');
    return Run.fromJson(jsonDecode(response.body));

  }
}
