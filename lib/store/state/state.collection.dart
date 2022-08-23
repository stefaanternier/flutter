import 'dart:collection';

import 'package:youplay/models/game.dart';

class CollectionState {

  final Set<String> ids;
  final HashMap<String, Game> entities;

  const CollectionState({required this.ids, required this.entities});

  static CollectionState initState() => CollectionState(ids: <String>{}, entities: HashMap());

  CollectionState copyWithGames(Iterable<Game> newGames) => CollectionState(
    ids: ids..addAll((newGames).map((e) => e.id)),
    entities: HashMap<String, Game>.from(entities)..addEntries((newGames).map((e) => MapEntry(e.id, e))),
  );

  CollectionState copyWithGame(Game newGame) => CollectionState(
    ids: ids..add(newGame.id),
    entities: HashMap<String, Game>.from(entities)..putIfAbsent(newGame.id, () => newGame),
  );

  dynamic toJson() => {'entities': entities.values.map((e) => e.toJson()).toList()};

  factory CollectionState.fromJson(Map json) {
    return initState()
        .copyWithGames((((json['entities'] ?? []) as List<dynamic>)).map((gameJson) => Game.fromJson(gameJson)));
  }
}
