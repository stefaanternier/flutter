import 'package:redux/redux.dart';
import 'package:youplay/store/actions/actions.organisations.dart';
import 'package:youplay/store/state/state.organisation.dart';

final organisationReducer = combineReducers<OrganisationState>([
  TypedReducer<OrganisationState, LoadOrganisationSuccess>((OrganisationState state, LoadOrganisationSuccess action) => state.copyWithOrganisation(action.organisation)),
  TypedReducer<OrganisationState, SetHomeOrganisation>((OrganisationState state,   SetHomeOrganisation action) => state.setHome(action.organisationId)),
]);