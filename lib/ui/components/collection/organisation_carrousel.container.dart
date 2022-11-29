import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/organisation.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/selector.collection.dart';
import 'package:youplay/store/selectors/selector.organisation.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/ui_state.dart';
import 'package:youplay/ui/components/misc/list_separation_text.dart';

import 'featured_game_carrousel.dart';

class OrganisationCarrouselContainer extends StatelessWidget {
  const OrganisationCarrouselContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {

          return Visibility(
              visible: vm.currentOrganisation != null,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListSeparationText(text: vm.currentOrganisation!.name),
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
    return _ViewModel(
        games: organisationGamesSelector(store.state),
        currentOrganisation: homeOrganisation(store.state),
        openGame: (Game g) {
          store.dispatch(new SetPage(page: PageType.gameLandingPage, gameId: g.gameId));

        }
    );
  }
}
