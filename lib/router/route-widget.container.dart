import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/router/route-widget.dart';
import 'package:youplay/router/router-delegate-with-state.dart';
import 'package:youplay/router/youplay-route-information-parser.dart';
import 'package:youplay/router/youplay-route-path.dart';
import 'package:youplay/store/actions/actions.collection.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/ui_selectors.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/ui_state.dart';

class RouteWidgetContainer extends StatelessWidget {
  // BookRouteInformationParser routeInformationParser;

  RouteWidgetContainer(
      {
      // required this.routeInformationParser,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      distinct: true,
      builder: (context, vm) {
        return RouteWidget(
          routeInformationParser: YouplayRouteInformationParser(updatePageType: vm.updatePageType),
          routerDelegate: new YouplayRouterDelegate(
              youplayRoutePath: YouplayRoutePath(
                  pageType: vm.pageType, pageId: vm.pageId, gameId: vm.gameId, runId: vm.runId, itemId: vm.itemId),
              updateYouplayRoutePath: vm.updateYouplayRoutePath),
          key: ValueKey('RouteWidget'),
        );
      },
    );
  }
}

class _ViewModel {
  Function(PageType, int?, int?) updatePageType;
  Function(YouplayRoutePath) updateYouplayRoutePath;
  PageType pageType;
  int? pageId;
  int? gameId;
  int? runId;
  int? itemId;

  _ViewModel(
      {required this.updatePageType,
      required this.updateYouplayRoutePath,
      required this.pageType,
      this.pageId,
      this.gameId,
      this.runId,
      this.itemId});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      updatePageType: (PageType pt, int? pId, int? gameId) {
        print('update page from YouplayRouteInformationParser, $pId');
        if (gameId != null) {
          store.dispatch(new ParseLinkAction(link:'http://play.bibendo.nl/#/game/$gameId'));
        }
        // store.dispatch(SetPage(page: pt, pageId: pId));
      },
      updateYouplayRoutePath: (YouplayRoutePath youplayRoutePath) {
        store.dispatch(SetPage(
            page: youplayRoutePath.pageType,
            pageId: youplayRoutePath.pageId,
            gameId: youplayRoutePath.gameId,
            runId: youplayRoutePath.runId,
            itemId: youplayRoutePath.itemId));
      },
      pageType: currentPage(store.state),
      pageId: currentPageId(store.state),
      gameId: currentGameIdState(store.state),
      runId: currentRunIdState(store.state),
      itemId: currentItemIdSel(store.state),
    );
  }

  bool operator ==(Object other) {
    _ViewModel otherViewModel = other as _ViewModel;
    // print ("route test is ${(other.pageType == pageType) & (other.pageId == pageId) & (other.itemId == itemId)}" );
    return (other.pageType == pageType) & (other.pageId == pageId) & (other.itemId == itemId);
  }

  @nonVirtual
  @override
  int get hashCode => pageType.index * (pageId ?? 1) * (itemId ?? 1);
}
