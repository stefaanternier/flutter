import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/pages/splashscreen.dart';

class SplashScreenContainer extends StatefulWidget {
  final Function() finished;

  const SplashScreenContainer({required this.finished, Key? key}) : super(key: key);

  @override
  State<SplashScreenContainer> createState() => _SplashScreenContainerState();
}

class _SplashScreenContainerState extends State<SplashScreenContainer> {

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 2),
          () {
        widget.finished();
        // store.dispatch(new SetPage(page: PageType.featured));
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store, this.widget.finished),
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


    return _ViewModel(onTap: () {
      // store.dispatch(new SetPage(page: PageType.featured));
    });
  }

  bool operator ==(Object other) {
      return true;
  }

  @override
  int get hashCode => 1;
}
