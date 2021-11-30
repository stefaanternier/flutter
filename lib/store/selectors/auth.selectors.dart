
import 'package:reselect/reselect.dart';
import 'package:youplay/models/models.dart';
import 'package:youplay/store/state/auth.state.dart';

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

