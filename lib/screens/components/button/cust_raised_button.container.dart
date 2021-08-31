import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/state/app_state.dart';

import 'cust_raised_button.dart';

class CustomRaisedButtonContainer extends StatelessWidget {
  Function() onPressed;
  String title;
  Icon? icon;
  bool disabled;

  CustomRaisedButtonContainer({required this.onPressed,
  required this.title,
  this.icon,
  this.disabled = false,
    Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      distinct: true,
      builder: (context, vm) {
        return CustomRaisedButton(
          onPressed: onPressed,
          title: title,
          icon: icon,
          primaryColor: vm.color
        );
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
