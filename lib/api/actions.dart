import 'dart:convert';
import 'package:youplay/models/run.dart';

import 'GenericApi.dart';
class ActionsApi extends GenericApi {
  // static  String apiUrl = AppConfig().baseUrl;
  //
  // static Future<String> getIdToken() async {
  //   User user = FirebaseAuth.instance.currentUser;
  //   String token = await user.getIdToken(true);
  //   return token;
  // }

  static Future<ARLearnAction> submitAction(ARLearnAction action) async {
    final response = await GenericApi.post(
        'api/action/create',
        action
    );

    // final response = await http.post(url,
    //     headers: {"Authorization": "Bearer " + await getIdToken()},
    //     body:json.encode(action)
    //     );
//    print("json ${response.body}");
    return ARLearnAction.fromJson(jsonDecode(response.body));
  }

  static Future<ARLearnActionsList> getActions(int runId, int from, String resumptionToken) async {

    // var url = Uri.https(AppConfig().baseUrl, 'api/actions/run/$runId/from/$from/$resumptionToken');
    // final response = await http.get(url,
    //     headers: {"Authorization": "Bearer " + await getIdToken()}
    // );
    final response = await GenericApi.get('api/actions/run/$runId/from/$from/$resumptionToken');
    return ARLearnActionsList.fromJson(jsonDecode(response.body));

  }
}
