import 'dart:collection';

import 'package:youplay/models/organisation_mapping.dart';

class OrganisationMappingState {
  final Set<String> ids;
  final HashMap<String, OrganisationMapping> entities;


  const OrganisationMappingState({required this.ids, required this.entities});

  static OrganisationMappingState initState() => OrganisationMappingState(ids: <String>{}, entities: HashMap());

  OrganisationMappingState copyWithOrganisationMappings(Iterable<OrganisationMapping> newMappings) => OrganisationMappingState(
    ids: ids..addAll((newMappings).map((e) => e.id)),
    entities: HashMap<String, OrganisationMapping>.from(entities)..addEntries((newMappings).map((e) => MapEntry(e.id, e))),
  );

  OrganisationMappingState copyWithOrganisationMapping(OrganisationMapping newMapping) => OrganisationMappingState(
    ids: ids..add(newMapping.id),
    entities: HashMap<String, OrganisationMapping>.from(entities)..putIfAbsent(newMapping.id, () => newMapping),
  );

  dynamic toJson() =>
      {'entities': entities.values.map((e) => e.toJson()).toList()};

  factory OrganisationMappingState.fromJson(Map json) {
    return initState()
        .copyWithOrganisationMappings((((json['entities'] ?? []) as List<dynamic>)).map((gameJson) => OrganisationMapping.fromJson(gameJson)));
  }

}
