import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/messages_parts/richtext-top.dart';


class RichTextTopContainer extends StatelessWidget {
  const RichTextTopContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return RichTextTop(
          color: vm.color,
          richText: vm.item?.richText,
        );
      },
    );
  }
}

class _ViewModel {
  Color color;
  GeneralItem? item;

  _ViewModel({required this.color, this.item});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        color: itemColor(store.state), item: currentGeneralItem(store.state));
  }
}
