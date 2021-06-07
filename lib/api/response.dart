import 'dart:convert';
import 'package:youplay/config/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:youplay/models/response.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResponseApi {

  static Future<String> getIdToken() async {
    User user = FirebaseAuth.instance.currentUser;
    String token = await user.getIdToken(true);
    return token;
  }

  static Future<Response> postResponse(final Response response) async {
    if (response == null) {
      print("ERROR! reponse is null in post RESPONSE");
    }
    var url = Uri.https(AppConfig().baseUrl, 'api/run/response');
    final httpResponse = await http.post(url,
        headers: {"Authorization": "Bearer " + await getIdToken()},
        body: json.encode(response.toJson())
    );
    // print('response from server ${httpResponse.body}');
    return Response.fromJson(jsonDecode(httpResponse.body));
  }

  static Future<ResponseList> getResponseForMe( int runId, int itemId) async {
    String idToken = await getIdToken();
    var url = Uri.https(AppConfig().baseUrl, 'api/run/response/runId/$runId/item/$itemId/me');
    final httpResponse = await http.get(url,
        headers: {"Authorization": "Bearer " + await getIdToken()}
    );
    // print('${httpResponse.body} $idToken');
    return ResponseList.fromJson(jsonDecode(httpResponse.body));
  }

  static Future<ResponseList> getResponse( int runId, int from, int until, String cursor) async {
    var url = Uri.https(AppConfig().baseUrl, 'api/run/response/runId/$runId/from/$from/until/$until/cursor/$cursor/me');
    if (cursor == null) {
      cursor = '*';
    }
    final httpResponse = await http.get(url,
        headers: {"Authorization": "Bearer " + await getIdToken()}
    );
    return ResponseList.fromJson(jsonDecode(httpResponse.body));
  }

  static Future<Response> deleteResponse( final int responseId) async {
    var url = Uri.https(AppConfig().baseUrl, 'api/run/response/$responseId');
    final httpResponse = await http.delete(url,
        headers: {"Authorization": "Bearer " + await getIdToken()}
    );
    return Response.fromJson(jsonDecode(httpResponse.body));
  }
}
