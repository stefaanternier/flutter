import 'dart:collection';

import 'package:youplay/models/game.dart';
import 'package:youplay/models/run.dart';

class GameLibraryState {
  List<Game> partialFeaturedGames;
  List<Game> partialSearchedGames = [];
  List<Game> recentGames = [];
  Map<int, Game> fullGames = new HashMap();

  Run? featuredRun;

  GameLibraryState(
      {required this.partialFeaturedGames,
      required this.partialSearchedGames,
      required this.recentGames,
      required this.fullGames,
      this.featuredRun});

  GameLibraryState copyWith(
      {partialGames,
      partialSearchedGames,
      recentGames,
      Game? oneGame,
      Run? oneRun}) {
    GameLibraryState state = new GameLibraryState(
        partialFeaturedGames: this.partialFeaturedGames,
        partialSearchedGames: this.partialSearchedGames,
        recentGames: recentGames ?? this.recentGames,
        fullGames: new HashMap.from(this.fullGames),
        featuredRun: oneRun ?? this.featuredRun);
    if (partialGames != null) {
      state.partialFeaturedGames = partialGames;
    }
    if (partialSearchedGames != null) {
      state.partialSearchedGames = partialSearchedGames;
    }
    if (oneGame != null) {
      state.fullGames[oneGame.gameId] = oneGame;
    }
    return state;
  }
}
