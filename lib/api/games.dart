import 'dart:convert';

import 'package:youplay/models/game.dart';
import 'package:youplay/store/actions/errors.dart';

import 'GenericApi.dart';

class GamesApi extends GenericApi {

  static Future<dynamic> participateGameIds() async {
    final response = await GenericApi.get('api/games/participateIds');
    print('in participate response ${response.body}');
    return response.body;
  }

  static Stream<Game> newGetGame(int gameId) async *{
    final response = await GenericApi.get('api/game/$gameId');
    try {
      yield Game.fromJson(jsonDecode(response.body));
    } catch (e) {
      print('error in getGame api/game/$gameId');
    }
  }

  static Future<dynamic> game(int gameId) async {
    final response = await GenericApi.get('api/game/$gameId');

    Map<String, dynamic> gameMap = jsonDecode(response.body);
    if (gameMap.containsKey("error")) {
      if (gameMap["error"] == "game does not exist") {
        print('game does not exist');
        return null;
      }
      return new ApiResultError(error: gameMap["error"]["code"], message: 'problem accessing: api/game/$gameId');
    }

    return Game.fromJson(gameMap);
  }
}
