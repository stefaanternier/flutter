import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/game_theme.dart';
import 'package:youplay/store/actions/game_theme.actions.dart';
import 'package:youplay/store/selectors/game_theme.selectors.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/icon/game_icon.dart';


class GameIconContainer extends StatelessWidget {

  Game? game;
  double height;

  GameIconContainer({
    required this.game,
    this.height = 59,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (game == null){
      return GameIcon(
        height: height,
      );
    }
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store, game!),
      distinct: true,
      builder: (context, vm) {
        return GameIcon(
          game: vm.game,
          height: height,
          iconPath: vm.iconPath(),
        );
      },
    );
  }
}

class _ViewModel {
  Game game;
  GameTheme? gameTheme;

  _ViewModel({required this.game, this.gameTheme});

  static _ViewModel fromStore(Store<AppState> store, Game game) {
    if (allThemesSelector(store.state)['${game.theme}'] == null && game.theme != 0) {
      store.dispatch(LoadGameTheme(themeIdentifier: game.theme));
    }

    return _ViewModel(
        game: game,
        gameTheme: allThemesSelector(store.state)['${game.theme}']
    );
  }

  String? iconPath() {
    return gameTheme?.iconPath;
  }

  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is _ViewModel && (other.gameTheme?.themeId == gameTheme?.themeId);
  }
  // if (this.gameTheme == null && other.gameTheme  == null) {
  // return true;
  // }
  @override
  int get hashCode => gameTheme?.themeId ?? -1;
}
