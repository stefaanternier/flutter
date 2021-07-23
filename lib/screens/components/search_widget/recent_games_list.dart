import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:youplay/screens/components/search_widget/recent_games_list.viewmodel.dart';
import 'package:youplay/store/state/app_state.dart';

import 'game_info_list_tile.dart';

class RecentGamesResultList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat.yMMMMd(Localizations.localeOf(context).languageCode);
    return new StoreConnector<AppState, RecentGamesListViewModel>(
        distinct: true,
        converter: (store) => RecentGamesListViewModel.fromStore(store),
        builder: (context, gameListModel) {

          return Column(
              children: List<GameInfoListTile>.generate(
                  gameListModel.games.length,
                  (i) => GameInfoListTile(game: gameListModel.games[i], openGame: ((index)=>((){
                    gameListModel.openGame(gameListModel.games[index]);
                  }))(i))
              ));
        });
  }
}
