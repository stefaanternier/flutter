import 'dart:convert';

import 'package:permission_handler/permission_handler.dart';
import 'package:youplay/api/GenericApi.dart';
import 'package:youplay/models/general_item.dart';
import '../../models/game.dart';

class GeneralItemsAPI extends GenericApi {
  GeneralItemsAPI._();

  static final GeneralItemsAPI instance = GeneralItemsAPI._();

  Future<GeneralItemList> getGameMessages(String gameId) async {
    final response = await GenericApi.get('api/generalItems/gameId/$gameId/cursor/*');
    if (response.statusCode == 200) {
      return GeneralItemList.fromJson(jsonDecode(response.body));
    }
    throw Exception('Some arbitrary error ${response.statusCode}');
  }

  Future<GeneralItemList> resumeGameMessages(String gameId, String? resumptionToken) async {
    if (resumptionToken != null) {
      final response = await GenericApi.get('api/generalItems/gameId/$gameId/cursor/$resumptionToken');
      if (response.statusCode == 200) {
        return GeneralItemList.fromJson(jsonDecode(response.body));
      }
    }
    throw Exception('Some arbitrary error');
  }
}
