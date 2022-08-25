import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/store/selectors/selector.generalitems.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/appbar/themed-appbar.dart';

import '../../../store/selectors/selector.gametheme.dart';

class ThemedAppbarContainer extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;
  final bool elevation;
  final List<Widget>? actions;
  ThemedAppbarContainer({Key? key, required this.title, this.elevation = true, this.actions}) : preferredSize = Size.fromHeight(50.0),
        super(key: key);


  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (context, vm) {
        return ThemedAppBar(
          title: title,
          elevation: elevation,
          color: vm.getPrimaryColor(),
          actions: actions
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
      itemPrimaryColor: currentGeneralItemNew(store.state) == null ? null : currentGeneralItemNew(store.state)?.primaryColor,
      themePrimaryColor: currentGameThemeColor(store.state),
    );
  }

  Color getPrimaryColor() {
    return itemPrimaryColor?? themePrimaryColor ?? AppConfig().themeData!.primaryColor;
  }
}