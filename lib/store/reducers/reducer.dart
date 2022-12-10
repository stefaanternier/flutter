import 'package:youplay/models/models.dart';
import 'package:youplay/store/actions/auth.actions.dart';
import 'package:youplay/store/reducers/reducer.error.dart';
import 'package:youplay/store/reducers/reducer.games.dart';
import 'package:youplay/store/reducers/reducer.gametheme.dart';
import 'package:youplay/store/reducers/reducer.generalitems.dart';
import 'package:youplay/store/reducers/reducer.organisation_mapping.dart';
import 'package:youplay/store/reducers/reducer.organisations.dart';
import 'package:youplay/store/reducers/reducer.runs.dart';
import 'package:youplay/store/reducers/ui.reducer.dart';
import 'package:youplay/store/state/ui_state.dart';

import 'all_games.reducer.dart';
import 'auth.reducer.dart';
import 'current_run.reducer.dart';
import 'reducer.collection.dart';

AppState appReducer(AppState state, action) {
  if (action is SignOutAction) {
    AppState newState = AppState.emptyState();
    newState.gameThemeState = state.gameThemeState;
    newState.uiState.currentPage = PageType.splash;
    return newState;
  }
  return new AppState(
      allGamesState: allGamesReducer(state.allGamesState, action),
      currentRunState: currentRunReducer(state.currentRunState, action),
      collectionState: collectionReducer(state.collectionState, action),
      errorState: errorReducer(state.errorState, action),
      gameState: gameReducer(state.gameState, action),
      gameThemeState: gameThemeReducer(state.gameThemeState, action),
      generalItemsState: generalItemsReducer(state.generalItemsState, action),
      organisationState: organisationReducer(state.organisationState, action),
      organisationMappingState: organisationMappingReducer(state.organisationMappingState, action),
      runState: runReducer(state.runState, action),
      authentication: authenticationReducer(state.authentication, action),
      uiState: uiReducer(state.uiState, action)
  );
}


