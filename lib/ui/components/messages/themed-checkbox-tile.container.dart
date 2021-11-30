import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/state/app_state.dart';

class ThemedCheckboxListTileContainer extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool?) onChanged;

  const ThemedCheckboxListTileContainer(
      {required this.title, required this.value, required this.onChanged, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      distinct: true,
      builder: (context, vm) {
        return CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(title,
                style: AppConfig().customTheme!.mcOptionTextStyle),
            value: value,
            onChanged: onChanged,
            activeColor: vm.color);
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
