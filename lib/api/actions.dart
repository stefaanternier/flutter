import 'dart:convert';

import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/run.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
class ActionsApi {
  static  String apiUrl = AppConfig().baseUrl;

  static Future<String> getIdToken() async {
    User user = FirebaseAuth.instance.currentUser;
    String token = await user.getIdToken(true);
    return token;
  }

  static Future<ARLearnAction> submitAction(ARLearnAction action) async {
    var url = Uri.https(AppConfig().baseUrl, 'api/action/create');
    final response = await http.post(url,
        headers: {"Authorization": "Bearer " + await getIdToken()},
        body:json.encode(action)
        );
//    print("json ${response.body}");
    return ARLearnAction.fromJson(jsonDecode(response.body));
  }


//  static Future<dynamic> getActions(int runId, int from, String idToken) async {
//    final response = await http.get(apiUrl + 'api/actions/run/${runId}/from/${from}/-',
//        headers: {"Authorization": "Bearer " + idToken}
//    );
//    print("body actions from server");
//
//    return jsonDecode(response.body);
//
//  }
  static Future<ARLearnActionsList> getActions(int runId, int from, String resumptionToken) async {
    var url = Uri.https(AppConfig().baseUrl, 'api/actions/run/$runId/from/$from/$resumptionToken');
    final response = await http.get(url,
        headers: {"Authorization": "Bearer " + await getIdToken()}
    );

    return ARLearnActionsList.fromJson(jsonDecode(response.body));

  }
}
