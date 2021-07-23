import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:youplay/screens/components/search_widget/search_result_list.viewmodel.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/icon/game_icon.container.dart';
class SearchResultList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DateFormat formatter =
    DateFormat.yMMMMd(Localizations.localeOf(context).languageCode);
    return new StoreConnector<AppState, SearchResultListViewModel>(
        distinct: true,
        converter: (store) => SearchResultListViewModel.fromStore(store),
        builder: (context, gameListModel) => Column(
            children: List<ListTile>.generate(
                gameListModel.games.length,
                (i) => ListTile(
                      leading: GameIconContainer(game: gameListModel.games[i]),
                      title: Text('${gameListModel.games[i].title}'),
                      subtitle: Text('${formatter.format(DateTime.fromMillisecondsSinceEpoch(gameListModel.games[i].lastModificationDate))} '),
                      onTap: () {
                        gameListModel.openGame(gameListModel.games[i]);
                      },
                      trailing: Icon(
                        !gameListModel.games[i].privateMode? Icons.lock: Icons.lock_open,
                        // color: Colors.green,
                        // size: 30.0,
                      ),
                    ))));
  }
}
