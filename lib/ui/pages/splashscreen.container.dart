import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/pages/splashscreen.dart';

class SplashScreenContainer extends StatelessWidget {
  final Function() finished;

  const SplashScreenContainer({required this.finished, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store, this.finished),
      distinct: true,
      builder: (context, vm) {
        return SplashScreen(
          onTap: vm.onTap,
        );
      },
    );
  }
}

class _ViewModel {
  final Function() onTap;

  _ViewModel({required this.onTap});

  static _ViewModel fromStore(Store<AppState> store, Function() tap) {
    Future.delayed(
      Duration(seconds: 2),
      () {
        tap();
        // store.dispatch(new SetPage(page: PageType.featured));
      },
    );

    return _ViewModel(onTap: () {
      // store.dispatch(new SetPage(page: PageType.featured));
    });
  }
}
