import 'dart:convert';
import 'package:youplay/config/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:youplay/models/response.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'GenericApi.dart';

class ResponseApi extends GenericApi {



  static Future<Response> postResponse(final Response response) async {
    final httpResponse = await GenericApi.post(
        'api/run/response',
        response.toJson()
    );
    return Response.fromJson(jsonDecode(httpResponse.body));
  }

  static Future<ResponseList> getResponseForMe( int runId, int itemId) async {
    final httpResponse = await GenericApi.get('api/run/response/runId/$runId/item/$itemId/me');
    return ResponseList.fromJson(jsonDecode(httpResponse.body));
  }

  static Future<ResponseList> getResponse( int runId, int from, int until, String nullCursor) async {
    String cursor = nullCursor;// ?? '*';
    final httpResponse = await GenericApi.get('api/run/response/runId/$runId/from/$from/until/$until/cursor/$cursor/me');
    return ResponseList.fromJson(jsonDecode(httpResponse.body));
  }

  static Future<Response> deleteResponse( final int responseId) async {
    final response = await GenericApi.delete('api/run/response/$responseId');
    return Response.fromJson(jsonDecode(response.body));
  }
}
