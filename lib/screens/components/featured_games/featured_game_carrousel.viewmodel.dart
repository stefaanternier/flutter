import 'package:redux/redux.dart';
import 'package:youplay/actions/runs.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/state/ui_state.dart';
import 'package:youplay/store/actions/current_game.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/game_library.selectors.dart';
import 'package:youplay/store/state/app_state.dart';

class FeaturedGamesCarrouselViewModel {
  List<Game> games;
  Function openGame;

  FeaturedGamesCarrouselViewModel({required this.games, required this.openGame});

  static FeaturedGamesCarrouselViewModel fromStore(Store<AppState> store) {
    return FeaturedGamesCarrouselViewModel(
        games: featuredGamesSelector(store.state),
        openGame: (Game g) {
          store.dispatch(LoadGameSuccessAction(game: g));
          store.dispatch(LoadPublicGameRequestAction(gameId: g.gameId));
          store.dispatch(ResetRunsAndGoToLandingPage());
//          store.dispatch(SetPage(PageType.gameLandingPage));
          if (store.state.authentication.authenticated) {
            store.dispatch(ApiRunsParticipateAction(g.gameId));
          }
        });
  }
}
