import 'dart:convert';

import 'package:http/http.dart';
import 'package:youplay/api/GenericApi.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/middlewares/auth.custom.middleware.dart';

import '../../models/game.dart';

class GameAPI extends GenericApi {
  GameAPI._();

  static final GameAPI instance = GameAPI._();

  Stream<Game> getGame(String gameId) async* {
    print('before get game');
    String token = await GenericApi.getIdToken();

    try {
    if (token == '') {
      final response = await GenericApi.get('api/game/$gameId/unauth');
      yield Game.fromJson(jsonDecode(response.body));
    } else {
      final response = await GenericApi.get('api/game/$gameId');
      print('status code ${response.statusCode}');
      print('status code ${response.body}');
      yield Game.fromJson(jsonDecode(response.body));
    }
    } catch (e) {
      print('error in getGame* api/game/$gameId');
      print('error is ${e}');
    }
  }

  Stream<Game> getGameFromRun(String runId) async* {
    final httpResponse = await getNew('api/run/$runId');
    if (httpResponse.statusCode != 401) {
      Run run = Run.fromJson(jsonDecode(httpResponse.body));
      final response = await GenericApi.getUnAuth('api/games/library/game/${run.gameId}');
      if (httpResponse.statusCode == 200) {
        yield Game.fromJson(jsonDecode(response.body));
      }
    }
  }

  Stream<Game> getGameFromRunUnAuth(String runId) async* {
    final httpResponse = await GenericApi.getUnAuth('api/run/$runId/unauth');
    print('run with game ${httpResponse.body}');
    if (httpResponse.statusCode != 401) {
      yield Game.fromJson(jsonDecode(httpResponse.body)['game']);
    }
  }

  Stream<String> getParticipateGameIds() async* {
    final response = await GenericApi.get('api/games/participateIds');
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json["items"] != null) {
        var myListIter = (json["items"] as List<dynamic>).iterator;
        //iterate over the list
        while (myListIter.moveNext()) {
          final String element = myListIter.current;
          yield element;
        }
      }
    }
  }
}
