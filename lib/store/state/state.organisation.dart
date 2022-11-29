import 'dart:collection';

import 'package:youplay/models/organisation.dart';

class OrganisationState {
  final Set<String> ids;
  final HashMap<String, Organisation> entities;

  final String? homeOrganisation;

  const OrganisationState({required this.ids, required this.entities, this.homeOrganisation});

  static OrganisationState initState() => OrganisationState(ids: <String>{}, entities: HashMap());

  OrganisationState copyWithGames(Iterable<Organisation> newGames) => OrganisationState(
        homeOrganisation: homeOrganisation,
        ids: ids..addAll((newGames).map((e) => e.id)),
        entities: HashMap<String, Organisation>.from(entities)..addEntries((newGames).map((e) => MapEntry(e.id, e))),
      );

  OrganisationState copyWithOrganisation(Organisation newGame) => OrganisationState(
        homeOrganisation: homeOrganisation,
        ids: ids..add(newGame.id),
        entities: HashMap<String, Organisation>.from(entities)..putIfAbsent(newGame.id, () => newGame),
      );

  dynamic toJson() =>
      {'homeOrganisation': homeOrganisation, 'entities': entities.values.map((e) => e.toJson()).toList()};

  factory OrganisationState.fromJson(Map json) {
    return initState()
        .copyWithGames((((json['entities'] ?? []) as List<dynamic>)).map((gameJson) => Organisation.fromJson(gameJson)))
        .setHome(json['homeOrganisation']);
  }

  setHome(String? organisationId) => organisationId == null? this: OrganisationState(ids: ids, entities: entities, homeOrganisation: organisationId);
}
