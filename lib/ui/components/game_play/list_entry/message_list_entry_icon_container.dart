import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/game_theme.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/store/selectors/selector.gametheme.dart';
import 'package:youplay/store/state/app_state.dart';

import 'message_list_entry_icon.dart';

class MessageEntryIconContainer extends StatelessWidget {
  GeneralItem item;
  bool read;
  MessageEntryIconContainer({required this.read,
    required this.item});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (context, vm) {
        print("entry icon ${item.title} - ${item.getIcon()}");
        return MessageEntryIcon(
          icon: item.getIcon(),
          primaryColor: read? Colors.grey : vm.gameTheme?.primaryColor ?? AppConfig().themeData!.primaryColor
        );
      },
    );
  }
}

class _ViewModel {
  GameTheme? gameTheme;

  _ViewModel({required this.gameTheme});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      gameTheme: currentThemeSelector(store.state)
    );
  }
}
