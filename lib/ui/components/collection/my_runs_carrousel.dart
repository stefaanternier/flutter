import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/organisation.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/selector.collection.dart';
import 'package:youplay/store/selectors/selector.games.dart';
import 'package:youplay/store/selectors/selector.organisation.dart';
import 'package:youplay/store/selectors/selector.runs.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/ui_state.dart';
import 'package:youplay/ui/components/misc/list_separation_text.dart';

import 'featured_game_carrousel.dart';

class MyGamesCarrouselContainer extends StatelessWidget {
  const MyGamesCarrouselContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {

        return Visibility(
            visible: vm.games.isNotEmpty,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListSeparationText(text: 'Verder spelen'),
                FeaturedGamesCarrousel(
                  games: vm.games,
                  openGame: vm.openGame,
                ),
              ],
            ));

      },
    );
  }
}


class _ViewModel {
  List<Game> games;
  Function(Game) openGame;
  Organisation? currentOrganisation;

  _ViewModel({
    required this.games, required this.openGame,
    this.currentOrganisation});

  static _ViewModel fromStore(Store<AppState> store) {
    List runs = recentRuns(store.state);

    return _ViewModel(
        games: recentGames(store.state),
        currentOrganisation: homeOrganisation(store.state),
        openGame: (Game g) {
          store.dispatch(new SetPage(page: PageType.gameLandingPage, gameId: g.gameId));

        }
    );
  }
}
