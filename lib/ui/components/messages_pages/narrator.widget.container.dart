import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/general_item/narrator_item.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/selectors/selector.generalitems.dart';
import 'narrator.widget.dart';

class NarratorWidgetContainer extends StatelessWidget {
  const NarratorWidgetContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      distinct: true,
      builder: (context, vm) {
        return NarratorWidget(
          item: vm.item
        );
      },
    );
  }
}

class _ViewModel {
  NarratorItem item;

  _ViewModel({required this.item});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      item: currentGeneralItemNew(store.state) as NarratorItem,
    );
  }

  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is _ViewModel && (other.item.itemId == item.itemId);
  }

  @override
  int get hashCode => item.itemId;
}
