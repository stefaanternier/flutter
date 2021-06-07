import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:youplay/actions/errors.dart';
import 'package:youplay/config/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:youplay/models/game.dart';
import 'package:youplay/models/game_theme.dart';

class GamesApi {
  static Future<String> getIdToken() async {
    User user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return '';
    }
    String token = await user.getIdToken(true);
    return token;
  }

  static Future<dynamic> participateGameIds() async {
    var url = Uri.https(AppConfig().baseUrl, 'api/games/participateIds');
    final response = await http.get(
        url,
        headers: {"Authorization": "Bearer " + await getIdToken()});

//    print(AppConfig().baseUrl + 'api/games/participateIds');
//    print(response.body);
    return response.body;
  }



  static Future<dynamic> game(int gameId) async {
    var url = Uri.https(AppConfig().baseUrl, 'api/game/$gameId');
    final response = await http.get(url,
        headers: {"Authorization": "Bearer " + await getIdToken()});
    Map<String, dynamic> gameMap = jsonDecode(response.body);
    if (gameMap.containsKey("error")) {
      if (gameMap["error"] == "game does not exist") {
        print('game does not exist');
        return null;
      }
      return new ApiResultError(error: gameMap["error"]["code"]);
    }

    return Game.fromJson(gameMap);
  }


  static Future<GameTheme> getTheme(int themeId) async {
    var url = Uri.https(AppConfig().baseUrl, 'api/game/theme/$themeId');
    final response = await http.get(url,
        headers: {"Authorization": "Bearer " + await getIdToken()});
    String idtoken = await getIdToken();
    // print("game response ${response.body} ${idtoken}");
    return GameTheme.fromJson(jsonDecode(response.body));
  }


}
