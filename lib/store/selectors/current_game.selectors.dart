import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/current_game_state.dart';

final gameStateFeature = (AppState state) => state.currentGameState;

final gameSelector = (GamesState state) => state.game;
final currentGameSelector = (AppState state) => state.currentGameState;

final amountOfRunsSelector = (GamesState state) => state.amountOfRuns;
final gameThemeSelector = (GamesState state) => state.gameTheme;
final gameThemePrimaryColorSelector = (GamesState state) => state.gameTheme?.primaryColor;

final gameSelectedSelector = (GamesState state) => state != null && state.game != null;
final currentGameTitleSelector =
    (GamesState state) => state != null && state.game != null ? state.game.title : "";

final currentGameId = (AppState state) =>
    (gameStateFeature(state) == null) ? -1 : gameStateFeature(state).game?.gameId;
