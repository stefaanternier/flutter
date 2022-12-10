import 'package:youplay/models/collection-response.dart';
import 'package:youplay/models/organisation_mapping.dart';

class LoadOrganisationMappingsSuccess {
  final CollectionResponse<OrganisationMapping> organisationMappings;
  const LoadOrganisationMappingsSuccess({required this.organisationMappings});
}