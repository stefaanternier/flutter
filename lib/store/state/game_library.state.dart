import 'dart:collection';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/run.dart';

class GameLibraryState {
  List<Game> partialFeaturedGames = [];
  List<Game> partialSearchedGames = [];
  List<Game> recentGames = [];
  Map<int, Game> fullGames = new HashMap();

  Run featuredRun;

  GameLibraryState() {}

  GameLibraryState copyWith(
      {partialGames, partialSearchedGames, recentGames, Game oneGame, Run oneRun}) {
    GameLibraryState state = new GameLibraryState();
    state.partialFeaturedGames = partialGames ?? this.partialFeaturedGames;
    state.partialSearchedGames = partialSearchedGames ?? this.partialSearchedGames;
    state.recentGames = recentGames ?? this.recentGames;
    state.fullGames = new HashMap.from(this.fullGames);
    if (oneGame != null) {
      state.fullGames[oneGame.gameId] = oneGame;
    }
    state.featuredRun = oneRun ?? this.featuredRun;
    return state;
  }
}
