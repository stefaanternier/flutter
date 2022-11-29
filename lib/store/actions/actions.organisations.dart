import 'package:youplay/models/organisation.dart';

class LoadOrganisationRequest {
  String organisationId;
  LoadOrganisationRequest({required this.organisationId});

  @override
  bool operator ==(dynamic other) {
    LoadOrganisationRequest o = other as LoadOrganisationRequest;
    return organisationId == o.organisationId;
  }

  @override
  int get hashCode => organisationId.hashCode;
}


class LoadOrganisationSuccess {
  final Organisation organisation;
  LoadOrganisationSuccess({required this.organisation});
}

class SetHomeOrganisation {
  final String organisationId;
  SetHomeOrganisation({required this.organisationId});
}