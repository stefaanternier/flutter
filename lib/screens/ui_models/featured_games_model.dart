import 'package:youplay/actions/games.dart';
import 'package:youplay/actions/ui.dart';
import 'package:youplay/selectors/authentication_selectors.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/state/authentication_state.dart';
import 'package:youplay/state/ui_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';
import 'package:youplay/store/actions/ui_actions.dart';

class FeaturedGamesModelDepr {


//  final Function(int runId, BuildContext ctx) onPlayClicked;

  final Function(int runId) playRun;
  final Function() requestLogin;

  FeaturedGamesModelDepr({this.requestLogin, @required this.playRun});

  static FeaturedGamesModelDepr fromStore(Store<AppState> store, BuildContext context) {
    return FeaturedGamesModelDepr(
        requestLogin: () {
          store.dispatch(new SetPage(PageType.login));
        },
        playRun: (int runId) {

          // store.dispatch(new RunQrAction("${runId}", context, store));
        });
  }
}

//dispatchGame(store, runId, ctx) async {
//  print("play clicked? ${runId} ${store} ${ctx}");
//  store.dispatch(new RunQrAction("${runId}", ctx, store));
//
//}
