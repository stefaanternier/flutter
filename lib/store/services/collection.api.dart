

import 'dart:convert';

import 'package:youplay/api/GenericApi.dart';
import 'package:youplay/models/run.dart';

import '../../models/game.dart';


class CollectionAPI extends GenericApi {
  CollectionAPI._();
  static final CollectionAPI instance = CollectionAPI._();

  Stream<GameList> recentGames() async *{
    final response = await GenericApi.get('api/games/library/recent');
    if (response.statusCode == 200) {
      yield GameList.fromJson(jsonDecode(response.body));
    }

  }

}
