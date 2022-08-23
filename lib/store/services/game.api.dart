

import 'dart:convert';

import 'package:youplay/api/GenericApi.dart';
import 'package:youplay/models/run.dart';

import '../../models/game.dart';


class GameAPI extends GenericApi {
  GameAPI._();
  static final GameAPI instance = GameAPI._();

  Stream<Game> getGame(String gameId) async *{
    print ('get game ${gameId}');
    final response = await GenericApi.get('api/game/$gameId');
    try {

      yield Game.fromJson(jsonDecode(response.body));
    } catch (e) {
      print('error in getGame api/game/$gameId');
    }
  }

  Stream<String> getParticipateGameIds() async *{
    final response = await GenericApi.get('api/games/participateIds');
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json["items"] != null) {
        var myListIter =  (json["items"] as List<dynamic>).iterator;
        //iterate over the list
        while(myListIter.moveNext()){
          final String element = myListIter.current;
          if (element == "5212115224756224" || element == "6635847155712000") {
            print("element is ${myListIter.current}");
            yield element;
          }

        }
      }
    }

  }

}
