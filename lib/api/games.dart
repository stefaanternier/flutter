import 'dart:convert';

import 'package:youplay/store/actions/errors.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/game_theme.dart';

import 'GenericApi.dart';

class GamesApi extends GenericApi {
  // static Future<String> getIdToken() async {
  //   User user = FirebaseAuth.instance.currentUser;
  //   if (user == null) {
  //     return '';
  //   }
  //   String token = await user.getIdToken(true);
  //   return token;
  // }

  static Future<dynamic> participateGameIds() async {
    final response = await GenericApi.get('api/games/participateIds');
    return response.body;
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


  static Future<GameTheme> getTheme(int themeId) async {
    final response = await GenericApi.get('api/game/theme/$themeId');
    // var url = Uri.https(AppConfig().baseUrl, 'api/game/theme/$themeId');
    // final response = await http.get(url,
    //     headers: {"Authorization": "Bearer " + await getIdToken()});
    // String idtoken = await getIdToken();
    // print("game response ${response.body} ${idtoken}");
    return GameTheme.fromJson(jsonDecode(response.body));
  }


}
