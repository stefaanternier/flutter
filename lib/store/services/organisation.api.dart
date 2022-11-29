import 'dart:convert';
import 'package:youplay/api/GenericApi.dart';
import 'package:youplay/models/organisation.dart';

class OrganisationAPI extends GenericApi {
  OrganisationAPI._();

  static final OrganisationAPI instance = OrganisationAPI._();

  Stream<Organisation> getOrganisation(String organisationId) async* {
    print('before get Organisation');
    String token = await GenericApi.getIdToken();

    try {
      if (token == '') {
        // final response = await GenericApi.get('api/game/$organisationId/unauth');
        // yield Organisation.fromJson(jsonDecode(response.body));
      } else {
        final response = await GenericApi.get('api/organization/$organisationId');
        print('status code ${response.statusCode}');
        print('status code ${response.body}');
        yield Organisation.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print('error in getGame* api/game/$organisationId');
      print('error is ${e}');
    }
  }
}