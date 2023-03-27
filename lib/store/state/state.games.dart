import 'dart:collection';

import 'package:youplay/models/game.dart';

class GameState {
  final Set<String> ids;
  final HashMap<String, Game> entities;

  const GameState({required this.ids, required this.entities});

  static GameState initState() => GameState(ids: <String>{}, entities: HashMap());

  GameState copyWithGames(Iterable<Game> newGames) => GameState(
        ids: ids..addAll((newGames).map((e) => e.id)),
        entities: HashMap<String, Game>.from(entities)..addEntries((newGames).map((e) => MapEntry(e.id, e))),
      );

  GameState copyWithGame(Game newGame) => GameState(
        ids: ids..add(newGame.id),
        entities: HashMap<String, Game>.from(entities)..update(newGame.id, (value) => newGame, ifAbsent: () => newGame),
      );



  dynamic toJson() => {'entities': entities.values.map((e) => e.toJson()).toList()};

  factory GameState.fromJson(Map json) {
    return initState()
        .copyWithGames((((json['entities'] ?? []) as List<dynamic>)).map((gameJson) => Game.fromJson(gameJson)));
  }
}
