import 'dart:convert';

import 'package:youplay/api/GenericApi.dart';
import 'package:youplay/models/general_item.dart';
import '../../models/game.dart';

class GeneralItemsAPI extends GenericApi {
  GeneralItemsAPI._();

  static final GeneralItemsAPI instance = GeneralItemsAPI._();

  Stream<GeneralItemList> getGameMessages(String gameId) async* {
    final response = await GenericApi.get('api/generalItems/gameId/$gameId/cursor/*');
    try {
      if (response.statusCode == 200) {
        yield GeneralItemList.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print('error in getGame api/game/$gameId');
    }
  }

  Stream<GeneralItemList> resumeGameMessages(String gameId, String? resumptionToken) async* {
    if (resumptionToken != null) {
      final response = await GenericApi.get('api/generalItems/gameId/$gameId/cursor/$resumptionToken');
      try {
        if (response.statusCode == 200) {
          yield GeneralItemList.fromJson(jsonDecode(response.body));
        }
      } catch (e) {
        print('error in getGame api/game/$gameId');
      }
    }

  }
}
