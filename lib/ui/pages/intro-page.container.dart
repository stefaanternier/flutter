import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/ui_state.dart';

import 'intro-page.dart';

class IntroPageContainer extends StatefulWidget {
  const IntroPageContainer({Key? key}) : super(key: key);

  @override
  State<IntroPageContainer> createState() => _IntroPageContainerState();
}

class _IntroPageContainerState extends State<IntroPageContainer> {
  double page = 0;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      distinct: true,
      builder: (context, vm) {
        if (page == 0) {
          return IntroPage(
            next: () {
              setState(() {
                page += 1;
                print('page is ${page}');
              });
            },
            title: 'Welkom bij bibendo',
            subTitle: 'Speel hier serious games & apps',
            image: 'intro1',
            index: page,
          );
        }
        if (page == 1) {
          return IntroPage(
            next: () {
              setState(() {
                page += 1;
                print('page is ${page}');
              });
            },
            title: 'Speel games',
            subTitle: 'Start vanuit de collectie of scan een QR code',
            image: 'intro2',
            index: page,
          );
        }
        return IntroPage(
          next: vm.toCollection,
          title: 'Bijna klaar...',
          subTitle: 'Speel met een account of speel als gast',
          image: 'intro3',
          buttonAccent: true,
          index: 2,
        );
      },
    );
  }
}

class _ViewModel {
  Function() toCollection;

  _ViewModel({required this.toCollection});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(toCollection: () {
      store.dispatch(SetPage(page: PageType.featured));
    });
  }
}
