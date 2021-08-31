import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/state/app_state.dart';

import 'themed_card.dart';

class ThemedCardContainer extends StatelessWidget {
  final String buttonText;
  final String feedback;
  final Function() buttonClick;
  final GeneralItem item;

  const ThemedCardContainer(
      {required this.buttonText, required this.feedback, required this.buttonClick, required this.item, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      distinct: true,
      builder: (context, vm) {
        return ThemedCard(
            item: item, feedback: feedback, buttonText: buttonText, buttonClick: buttonClick, primaryColor: vm.color);
      },
    );
  }
}

class _ViewModel {
  Color color;

  _ViewModel({required this.color});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      color: itemColor(store.state),
    );
  }

  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is _ViewModel && (color.hashCode == other.color.hashCode);
  }

  @override
  int get hashCode => color.hashCode;
}
