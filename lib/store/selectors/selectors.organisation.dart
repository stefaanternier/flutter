import 'package:reselect/reselect.dart';
import 'package:youplay/models/organisation.dart';
import 'package:youplay/store/selectors/ui_selectors.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/state.organisation.dart';

final organisationFeatureSelector = (AppState state) => state.organisationState;

final Selector<AppState, Organisation?> currentOrganisation = createSelector2(
    currentPageIdState, organisationFeatureSelector, (int? orgId, OrganisationState orgState) => orgState.entities['$orgId']);
