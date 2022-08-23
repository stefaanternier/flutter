import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/game_library.selectors.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/ui_state.dart';

import 'featured_game_carrousel.dart';

class FeaturedGamesCarrouselContainer extends StatelessWidget {
  const FeaturedGamesCarrouselContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return FeaturedGamesCarrousel(
          games: vm.games,
          openGame: vm.openGame,
        );
      },
    );
  }
}


class _ViewModel {
  List<Game> games;
  Function(Game) openGame;

  _ViewModel({required this.games, required this.openGame});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        games: featuredGamesSelector(store.state),
        openGame: (Game g) {
          store.dispatch(new SetPage(page: PageType.gameLandingPage, gameId: g.gameId));

        }
        );
  }
}
