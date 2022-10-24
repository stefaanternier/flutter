import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/store/actions/actions.error.dart';
import 'package:youplay/store/state/app_state.dart';

class ErrorNotifier extends StatelessWidget {
  final Widget child;

  ErrorNotifier({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (context, vm) => child,
      onWillChange: (prev, vm) {
        if (vm.error != null && prev != vm) {
          print("handling error!!!!!");
          vm.markErrorAsHandled();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${vm.error.toString()}'),
          ));
        }
      },
      distinct: true,
    );
  }
}

class _ViewModel {
  _ViewModel({
    required this.markErrorAsHandled,
    required this.error,
  });

  final Function markErrorAsHandled;
  final Exception? error;

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      markErrorAsHandled: () => store.dispatch(ErrorHandledAction()),
      error: store.state.errorState.error,
    );
  }

  @override
  int get hashCode => error.hashCode;

  @override
  bool operator ==(other) => identical(this, other) || other is _ViewModel && other.error == this.error;
}
