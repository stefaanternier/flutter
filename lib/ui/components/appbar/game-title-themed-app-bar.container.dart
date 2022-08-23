import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/appbar/themed-appbar.container.dart';

import '../../../store/selectors/selector.games.dart';

class GameTitleThemedAppbarContainer extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  bool elevation = true;

  GameTitleThemedAppbarContainer({Key? key, this.elevation = true})
      : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (context, vm) {
        return ThemedAppbarContainer(
          title: vm.title,
          elevation: elevation,
        );
      },
    );
  }
}

class _ViewModel {
  String title;

  _ViewModel({required this.title});

  static _ViewModel fromStore(Store<AppState> store) => _ViewModel(
        title: currentGame(store.state)?.title ?? '-',
      );
}
