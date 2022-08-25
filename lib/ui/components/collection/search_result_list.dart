import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/icon/game_icon.container.dart';


class SearchResultListContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DateFormat formatter =
    DateFormat.yMMMMd(Localizations.localeOf(context).languageCode);
    return new StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: (store) => _ViewModel.fromStore(store),
        builder: (context, vm) => Column(
            children: List<ListTile>.generate(
                vm.games.length,
                (i) => ListTile(
                      leading: GameIconContainer(game: vm.games[i]),
                      title: Text('${vm.games[i].title}'),
                      subtitle: Text('${formatter.format(DateTime.fromMillisecondsSinceEpoch(vm.games[i].lastModificationDate))} '),
                      onTap: () {
                        vm.openGame(vm.games[i]);
                      },
                      trailing: Icon(
                        !vm.games[i].privateMode? Icons.lock: Icons.lock_open,
                        // color: Colors.green,
                        // size: 30.0,
                      ),
                    ))));
  }
}


class _ViewModel {
  List<Game> games;
  Function openGame;

  _ViewModel({required this.games,required  this.openGame});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        games: [],//searchedGamesSelector(store.state),
        openGame: (Game g) {
          // store.dispatch(LoadGameSuccessAction(game: g)); //todo reenable ?
          // store.dispatch(LoadPublicGameRequestAction(gameId :g.gameId));
        });
  }
}
