import 'dart:collection';

import 'package:youplay/models/game.dart';

class AllGamesState {
  List<int> participateGames = [];
  HashMap<int, Game> idToGame = new HashMap<int, Game>();
  String? query;

  AllGamesState({required this.participateGames, idToGame, this.query})
      : this.idToGame = idToGame ?? new HashMap<int, Game>();

  AllGamesState copyWith({pgs, i2g, q}) => new AllGamesState(
      participateGames: pgs ?? this.participateGames,
      idToGame: i2g ?? this.idToGame,
      query: q == '-' ? null : (q ?? this.query));

  AllGamesState removeGame(int gameId)  {
    idToGame.remove(gameId);
   return new AllGamesState(
       participateGames: this.participateGames.where((game) => game != gameId).toList(),
       idToGame: new HashMap<int, Game>.from(this.idToGame),
       query: this.query);
  }

}
