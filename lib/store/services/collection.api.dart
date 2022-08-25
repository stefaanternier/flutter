import 'dart:convert';

import 'package:youplay/api/GenericApi.dart';

import '../../models/game.dart';

class CollectionAPI extends GenericApi {
  CollectionAPI._();
  static final CollectionAPI instance = CollectionAPI._();

  Future<Game> loadOnePublicGame(String gameId) async {
    final response = await GenericApi.getUnAuth('api/games/library/game/$gameId');
    if (response.statusCode == 200) {
      return Game.fromJson(jsonDecode(response.body));
    }
    throw Exception('Response code is: ${response.statusCode}');
  }

  Future<GameList> featuredGames() async {
    final response = await GenericApi.getUnAuth('api/games/featured/nl');
    if (response.statusCode == 200) {
      return GameList.fromJson(jsonDecode(response.body));
    }
    throw Exception('Response code is: ${response.statusCode}');
  }


  Future<GameList> recentGames() async {
    final response = await GenericApi.getUnAuth('api/games/library/recent');
    if (response.statusCode == 200) {
      return GameList.fromJson(jsonDecode(response.body));
    }
    throw Exception('Response code is: ${response.statusCode}');
  }

  Future<GameList> resumeGameList(String token) async {
    final response = await GenericApi.getUnAuth('api/games/library/recent', {
      'resumptionToken' : token
    });
    if (response.statusCode == 200) {
      return GameList.fromJson(jsonDecode(response.body));
    }
    throw Exception('Response code is: ${response.statusCode}');
  }


}
