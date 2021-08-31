import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/state/app_state.dart';

import 'combination-lock.button.dart';

class CombinationLockButtonContainer extends StatelessWidget {
  final Function() unlock;

  const CombinationLockButtonContainer({
    required this.unlock,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      distinct: true,
      builder: (context, vm) {
        return Visibility(
          visible: !vm.correctAnswerGiven,
          child: CombinationLockButton(
              unlock: unlock,
            color: vm.color,
          ),
        );
      },
    );
  }
}

class _ViewModel {
  bool correctAnswerGiven;
  Color color;

  _ViewModel({ required this.color,
    required this.correctAnswerGiven,});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      color: itemColor(store.state),
      correctAnswerGiven: correctAnswerGivenSelector(store.state),
    );
  }

  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is _ViewModel && (other.correctAnswerGiven.hashCode == correctAnswerGiven.hashCode);
  }

  @override
  int get hashCode => correctAnswerGiven.hashCode;
}
