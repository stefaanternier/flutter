import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/game_theme.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/selectors/game_theme.selectors.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/appbar/themed-appbar.dart';
import 'package:youplay/ui/components/icon/game_icon.dart';
import 'package:youplay/ui/components/messages_parts/richtext-top.dart';

class ThemedAppbarContainer extends StatelessWidget {
  final String title;
  bool elevation = true;
  ThemedAppbarContainer({Key? key, required this.title, this.elevation = true}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (context, vm) {
        return ThemedAppBar(
          title: title,
          elevation: elevation,
          color: vm.getPrimaryColor()
        );

      },
    );
  }
}

class _ViewModel {
  Color? itemPrimaryColor;
  Color? themePrimaryColor;

  _ViewModel({ this.itemPrimaryColor, this.themePrimaryColor});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
      itemPrimaryColor: currentGeneralItem(store.state) == null ? null : currentGeneralItem(store.state)?.primaryColor,
      themePrimaryColor: gameThemePrimaryColorSelector(store.state.currentGameState),
    );
  }

  Color getPrimaryColor() {
    return itemPrimaryColor?? themePrimaryColor ?? AppConfig().themeData!.primaryColor;
  }
}