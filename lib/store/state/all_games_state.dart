import 'dart:collection';
import 'package:youplay/models/game.dart';

class AllGamesState {
  List<int> participateGames = [];
  HashMap<int, Game> idToGame = new HashMap<int, Game>();

  AllGamesState({
    required this.participateGames, idToGame}):
  this.idToGame = idToGame ??  new HashMap<int, Game>()
  ;

  AllGamesState copyWith({pgs, i2g}) => new AllGamesState(
      participateGames: pgs ?? this.participateGames, idToGame: i2g ?? this.idToGame);
}
