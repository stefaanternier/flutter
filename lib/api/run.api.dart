

import 'dart:convert';

import 'package:youplay/models/run.dart';

import 'GenericApi.dart';

class RunAPI extends GenericApi {
  RunAPI._();
  static final RunAPI instance = RunAPI._();

  Stream<Run> getRunUnAuth(String runId) async* {
    final httpResponse = await getNew('api/run/$runId/unauth');
    if (httpResponse.statusCode != 401) {
      yield Run.fromJson(jsonDecode(httpResponse.body));
    }
  }

  Stream<Run> getRunAuth(String runId) async* {
    final httpResponse = await getNew('api/run/$runId');
    if (httpResponse.statusCode != 401) {
      yield Run.fromJson(jsonDecode(httpResponse.body));
    }
  }


  Stream<RunList> participate(String gameId) async* {
    print('before in participate for gameId $gameId');
    final httpResponse = await getNew('api/runs/participate/$gameId');
    print('in participate for gameId $gameId');
    if (httpResponse.statusCode == 200) {
      yield RunList.fromJson(jsonDecode(httpResponse.body));
      print('after in participate for gameId $gameId');
    }
  }

  Stream<bool> deletePlayerFromRun(String runId) async* {
    final httpResponse = await GenericApi.delete('api/runs/player/me/$runId');
    if (httpResponse.statusCode == 200) {
      yield true;
    } else {
      yield false;
    }
  }

}
