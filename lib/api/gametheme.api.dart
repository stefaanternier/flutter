

import 'dart:convert';

import '../models/game_theme.dart';
import 'GenericApi.dart';

class GameThemeAPI extends GenericApi {
  GameThemeAPI._();
  static final GameThemeAPI instance = GameThemeAPI._();


  Stream<GameTheme> getGameTheme(String themeId) async* {
    dynamic httpResponse = await getNew('api/game/theme/$themeId');
    if (httpResponse.statusCode == 204) {
      httpResponse = await getNew('api/game/theme/1');
    }
    yield GameTheme.fromJson(jsonDecode(httpResponse.body));

  }

}
