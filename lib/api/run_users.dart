import 'package:youplay/config/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

import 'GenericApi.dart';

class UsersApi  extends GenericApi {

  static Future<dynamic> runUsers() async {
    final response = await GenericApi.get('api/run/users');
    return response.body;
  }
}
