import 'dart:math';

import 'package:youplay/models/models.dart';
import 'package:youplay/state/authentication_state.dart';
import 'package:reselect/reselect.dart';

AuthenticationState uiState(AppState state) => state.authentication;

final Selector<AppState, bool> isAuthenticatedSelector= createSelector1(
    uiState, ( AuthenticationState authState) {
  return authState.authenticated;
});

final Selector<AppState, bool> isAnonSelector = createSelector1(
    uiState, ( AuthenticationState authState) {
  return authState.anon;
});

final Selector<AppState, AuthenticationState> authenticationInfo = createSelector1(
    uiState, ( AuthenticationState authState) {
  return authState;
});

