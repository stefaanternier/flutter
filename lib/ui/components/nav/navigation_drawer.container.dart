import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/organisation.dart';
import 'package:youplay/store/actions/auth.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/auth.selectors.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/selectors/selector.games.dart';
import 'package:youplay/store/selectors/selector.organisation.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/auth.state.dart';
import 'package:youplay/store/state/ui_state.dart';

import '../../../store/actions/actions.collection.dart';
import 'navigation_drawer.dart';

class ARLearnNavigationDrawerContainer extends StatelessWidget {
  const ARLearnNavigationDrawerContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return ARLearnNavigationDrawer(
          showCurrentGame: vm.showCurrentGame(),
          currentGameTitle: vm.currentGameTitle,
          tapCollection: vm.tapCollection,
          organisation: vm.currentOrganisation,
          tapPage: (PageType page, String? id) {
            if (id == null) {
              vm.onPageClicked(page, null);
            } else {
              vm.onPageClicked(page, int.parse(id));
            }
          },
          tapExit: () {
            if (vm.anon) {
              vm.onAnonErase();
            } else {
              vm.onLogoutClicked();
            }
          },
          isAnon: vm.anon,
          isAuthenticated: vm.isAuthenticated,
        );
      },
    );
  }
}

class _ViewModel {
  bool isAuthenticated;
  bool anon;

//  bool showCurrentGame;
  String currentGameTitle;
  String currentRunTitle;
  Organisation? currentOrganisation;
  final Function(PageType, int?) onPageClicked;
  final Function() onLogoutClicked;
  final Function() onAnonErase;
  final Function() tapCollection;

  _ViewModel(
      {required this.isAuthenticated,
      required this.anon,
      required this.currentGameTitle,
      required this.currentRunTitle,
      required this.tapCollection,
      required this.onPageClicked,
      required this.onLogoutClicked,
      required this.onAnonErase,
      this.currentOrganisation});

  static _ViewModel fromStore(Store<AppState> store) {
    AuthenticationState authenticationState = authenticationInfo(store.state);
    return _ViewModel(
        isAuthenticated: authenticationState.authenticated,
        anon: authenticationState.anon,
        currentGameTitle: currentGame(store.state)?.title ?? '',
        currentOrganisation: homeOrganisation(store.state),
        tapCollection: () {
          store.dispatch(LoadFeaturedGameRequest());
          store.dispatch(LoadRecentGameRequest());
        },
        currentRunTitle: currentRunSelector(store.state.currentRunState)?.title ?? "",
        onPageClicked: (PageType page, int? id) {
          store.dispatch(new SetPage(page: page, pageId: id));
        },
        onAnonErase: () {
          store.dispatch(new EraseAnonAccount());
        },
        onLogoutClicked: () {
          store.dispatch(new SignOutAction());
        });
  }

  bool showCurrentGame() {
    return this.currentGameTitle != "" && currentRunTitle != "";
  }
}
