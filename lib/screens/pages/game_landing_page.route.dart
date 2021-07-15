import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/screens/pages/game_landing_page.dart';
import 'package:youplay/screens/pages/home_page.dart';
import 'package:youplay/store/actions/game_library.actions.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/messages_parts/richtext-top.dart';

class GameLandingPageRoute extends StatefulWidget {
  String game;

  GameLandingPageRoute({Key? key, required this.game}) : super(key: key);

  @override
  _GameLandingPageRouteState createState() => _GameLandingPageRouteState();
}

class _GameLandingPageRouteState extends State<GameLandingPageRoute> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return LpStateful(f: () => vm.dispatch(widget.game));
      },
    );
  }
}


class _ViewModel {
  Function(String) dispatch;


  _ViewModel({required this.dispatch});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        dispatch: (String link) {
          store.dispatch(new ParseLinkAction(link: link));
        });
  }
}
//
class LpStateful extends StatefulWidget {
  Function f;
   LpStateful({
    required this.f,
    Key? key}) : super(key: key);

  @override
  _LpStatefulState createState() => _LpStatefulState();
}

class _LpStatefulState extends State<LpStateful> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }

  @override
  void initState() {
    widget.f();
  }
}

