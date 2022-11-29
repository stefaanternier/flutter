import 'package:reselect/reselect.dart';
import 'package:youplay/models/organisation.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/state.organisation.dart';

final organisationFeatureSelector = (AppState state) => state.organisationState;

final Selector<AppState, Organisation?> homeOrganisation =
    createSelector1(organisationFeatureSelector, (OrganisationState state) {
  return state.entities[state.homeOrganisation];
});
