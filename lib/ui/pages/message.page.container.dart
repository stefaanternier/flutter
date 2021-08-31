import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/state/app_state.dart';

import 'game_landing.page.loading.dart';
import 'message.page.dart';

class MessagePageContainer extends StatelessWidget {
  const MessagePageContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      distinct: true,
      builder: (context, vm) {
        if (vm.item == null) {
          return GameLandingLoadingPage(
              init: (){},
              text: "Even wachten, we proberen deze boodschap te laden...");
        }
        return vm.item!.buildPage();
      },
    );
  }
}

class _ViewModel {
  GeneralItem? item;

  _ViewModel({required this.item});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      item: currentGeneralItem(store.state),
    );
  }

  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is _ViewModel && (other.item?.itemId == item?.itemId);
  }

  @override
  int get hashCode => item?.itemId ?? -1;

}
