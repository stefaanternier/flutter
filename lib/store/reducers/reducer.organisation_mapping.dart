import 'package:redux/redux.dart';
import 'package:youplay/store/actions/actions.organisation_mappings.dart';
import 'package:youplay/store/actions/actions.organisations.dart';
import 'package:youplay/store/state/state.organisation_mappings.dart';

final organisationMappingReducer = combineReducers<OrganisationMappingState>([
  TypedReducer<OrganisationMappingState, LoadOrganisationMappingsSuccess>(
      (OrganisationMappingState state, LoadOrganisationMappingsSuccess action) =>
          state.copyWithOrganisationMappings(action.organisationMappings.items)),
]);
