import 'dart:collection';

import 'package:youplay/models/game_theme.dart';

class GameThemeState {
  final Set<String> ids;
  final HashMap<String, GameTheme> entities;

  const GameThemeState({required this.ids, required this.entities});

  static GameThemeState initState() {
    return GameThemeState(ids: <String>{}, entities: HashMap());
  }

  GameThemeState copyWithNewThemes(Iterable<GameTheme> newThemes) {
    return GameThemeState(
      ids: ids..addAll((newThemes).map((e) => e.id)),
      entities: HashMap<String, GameTheme>.from(entities)
        ..addEntries((newThemes).map((e) => MapEntry(e.id, e))),
    );
  }

  GameThemeState copyWithNewTheme(GameTheme newTheme) {
    return GameThemeState(
      ids: ids..add(newTheme.id),
      entities: HashMap<String, GameTheme>.from(entities)
        ..putIfAbsent(newTheme.id, () => newTheme),
    );
  }

}
