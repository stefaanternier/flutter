import 'package:youplay/actions/runs.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/models.dart';
import 'package:youplay/store/state/current_game_state.dart';
import 'package:redux/redux.dart';
import 'package:youplay/actions/games.dart';
import 'dart:convert';
import 'dart:collection';



final gameReducer = combineReducers< HashMap<int, GamesState>>([
  // new TypedReducer< HashMap<int, GamesState>, ApiResultGameAction>(_addGame),
  new TypedReducer< HashMap<int, GamesState>, ApiResultLoadRunAction>(_addRunWithGame),
//  new TypedReducer< HashMap<int, GamesState>, ApiResultGameGeneralItems>(_generalItems),
]);

HashMap<int, GamesState> _addRunWithGame( HashMap<int, GamesState> oldMap,
    ApiResultLoadRunAction action) {
  Map<String, dynamic> runMap =jsonDecode(action.run);
  Map<String, dynamic> gameMap = runMap['game'];
  Game game = new Game.fromJson(gameMap);
  HashMap<int, GamesState> map = HashMap<int, GamesState>.from(oldMap);
  if (map[game.gameId] ==  null) map.putIfAbsent(game.gameId, ()=>new GamesState());
  map[game.gameId]!.game = game;
  return map;
}

//todo deprecated
// HashMap<int, GamesState> _addGame( HashMap<int, GamesState> oldMap, ApiResultGameAction action) {
//   Map<String, dynamic> gameMap =jsonDecode(action.game);
//   Game game = new Game.fromJson(gameMap);
//   if (game.title == null) game.title = "no title";
//   HashMap<int, GamesState> map = HashMap<int, GamesState>.from(oldMap);
//   if (map[game.gameId] ==  null) map.putIfAbsent(game.gameId, ()=>new GamesState());
//   map[game.gameId].game = game;
//   return map;
// }

//HashMap<int, GamesState> _generalItems( HashMap<int, GamesState> oldMap, ApiResultGameGeneralItems action) {
//  var generalItemsList =jsonDecode(action.generalItems);
//
//  HashMap<int, GamesState> map = HashMap<int, GamesState>.from(oldMap);
//  if (map[action.gameId] ==  null) map.putIfAbsent(action.gameId, ()=>new GamesState());
//
//  (generalItemsList['generalItems'] as List)
//      .forEach((itemJson){
//        GeneralItem item = GeneralItem.fromJson(itemJson);
//        map[action.gameId].itemIdToGeneralItem.putIfAbsent(item.itemId, ()=>item);
//      });
//
//  return map;
//}



//final participateGames = combineReducers<List<Game>>([
//  new TypedReducer<List<Game>, ApiResultGamesParticipateAction>(_addParticipateGames),
//]);

//final participateGames = combineReducers<List<Game>>([
//final participateGames =  new TypedReducer<List<Game>, ApiResultGamesParticipateAction>(_addParticipateGames),
//]);


List<Game> participateGames(List<Game> items, dynamic action) {
  if (action.runtimeType != ApiResultGamesParticipateAction) return items;
//  var gamesList =jsonDecode(action.games);
  List<Game> returnList = [];
  (action.games['games'] as List).forEach((gameJson)=> returnList..add(new Game.fromJson(gameJson)));
  return returnList;
}
