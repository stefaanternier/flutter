import 'package:redux/redux.dart';
import 'package:youplay/models/game_theme.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/screens/general_item/util/messages/components/themed_app_bar.viewmodel.dart';
import 'package:youplay/selectors/ui_selectors.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/state/ui_state.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';

class CurrentGameViewModel {
  Game game;
  Run run;
  bool finished;
  MessageView messageView;
  Function dispatchToggleMessageView;
  GameTheme gameTheme;
  ThemedAppBarViewModel themedAppBarViewModel;

  CurrentGameViewModel(
      {this.game,
      this.messageView,
      this.dispatchToggleMessageView,
      this.run,
        this.gameTheme,
      this.themedAppBarViewModel,
      this.finished});

  static CurrentGameViewModel fromStore(Store<AppState> store) {
    Game game = gameSelector(store.state.currentGameState);
    return new CurrentGameViewModel(
        run: currentRunSelector(store.state.currentRunState),
        game: game,
        gameTheme: gameThemeSelector(store.state.currentGameState),
        messageView: messagesView(store.state),
        themedAppBarViewModel: ThemedAppBarViewModel.fromStore(store),
        finished: gameHasFinished(store.state),
        dispatchToggleMessageView: () {
          store.dispatch(new ToggleMessageViewAction(gameId: game.gameId));
        });
  }
}
