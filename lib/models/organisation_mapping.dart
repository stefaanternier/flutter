import 'package:youplay/store/actions/actions.organisations.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:redux/redux.dart';

class OrganisationMapping {

  final String id;
  final String gameId;
  final String organisationId;
  final bool deleted;

  const OrganisationMapping({
    required this.id,
    required this.gameId,
    required this.organisationId,
    required this.deleted,
  });

  static fromJsonStatic(Map json) {
    return OrganisationMapping.fromJson(json);
  }

  OrganisationMapping.fromJson(Map json)
      : id = json['id'],
        organisationId = json['organisationId'],
        deleted = json['deleted'] ?? false,
        gameId = json['gameId'];

  dynamic toJson() {
    return {
      'id': this.id,
      'gameId': this.gameId,
      'organisationId': this.organisationId,
      'deleted': this.deleted
    };
  }

}