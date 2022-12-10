import 'dart:convert';
import 'package:youplay/api/GenericApi.dart';
import 'package:youplay/models/collection-response.dart';
import 'package:youplay/models/organisation.dart';
import 'package:youplay/models/organisation_mapping.dart';

class OrgAPI extends GenericApi {
  OrgAPI._();

  static final OrgAPI instance = OrgAPI._();

  Stream<Organisation> getOrganisation(String organisationId) async* {
    print('before get Organisation');
    String token = await GenericApi.getIdToken();

    try {
      if (token == '') {

      } else {
        final response = await GenericApi.get('api/organization/$organisationId');
        yield Organisation.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print('error in getGame* api/game/$organisationId');
      print('error is ${e}');
    }
  }

  Future<CollectionResponse<OrganisationMapping>> orgMappings(String organisationId) async {
    final response = await GenericApi.get('api/games/library/organisation/games/$organisationId');
    if (response.statusCode == 200) {
      try {
        return CollectionResponse<OrganisationMapping>
            .fromJson(jsonDecode(response.body), OrganisationMapping.fromJsonStatic, "gameOrganisationList");
      } catch (e) {
        print('error ${e}');
      }
    }
    throw Exception('Response code is: ${response.statusCode}');
  }


}