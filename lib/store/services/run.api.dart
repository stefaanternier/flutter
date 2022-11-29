import 'dart:convert';

import 'package:youplay/api/GenericApi.dart';
import 'package:youplay/models/collection-response.dart';
import 'package:youplay/models/run.dart';

import '../../api/GenericApi.dart';

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
    final httpResponse = await getNew('api/runs/participate/$gameId');
    if (httpResponse.statusCode == 200) {
      yield RunList.fromJson(jsonDecode(httpResponse.body));
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

  Future<CollectionResponse<RunAccess>> recentRuns() async {
    int time = (new DateTime.now().millisecondsSinceEpoch - 2592000000 * 2);
    final response = await GenericApi.get('api/run/access/user/$time');
    if (response.statusCode == 200) {
      // print('response body is ${response.body}');
      try {
        return CollectionResponse<RunAccess>
            .fromJson(jsonDecode(response.body), RunAccess.fromJsonStatic, "runAccess");
      } catch (e) {
        print('error ${e}');
      }
    }
    throw Exception('Response code is: ${response.statusCode}');
  }

  Future<CollectionResponse<RunUser>> recentRunsUser() async {
    final response = await GenericApi.get('api/run/users');
    if (response.statusCode == 200) {
      try {
        return CollectionResponse<RunUser>
            .fromJson(jsonDecode(response.body), RunUser.fromJsonStatic, "users");
      } catch (e) {
        print('error ${e}');
      }
    }
    throw Exception('Response code is: ${response.statusCode}');
  }

}
