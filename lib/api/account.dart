import 'package:youplay/api/GenericApi.dart';
import 'package:youplay/models/account.dart';

class AccountApi extends GenericApi {

  static Future<dynamic> accountDetails() async {
    final response = await GenericApi.get('api/account/accountDetails');
    return response.body;
  }

  static Future<dynamic> eraseAnonAcount() async {
    final response = await GenericApi.get('api/account/eraseAnonAccount');
    return response.body;
  }

  static Future<dynamic> initNewAccount(String email, String displayName) async {
    Account acc = new Account(name: displayName, email: email);
    final response = await GenericApi.post(
        'api/account/update/displayName/asUser',
        acc.toJson()
    );
    return response.body;
  }
}
