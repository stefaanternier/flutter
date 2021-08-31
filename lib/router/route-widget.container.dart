import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/router/route-widget.dart';
import 'package:youplay/router/router-delegate-with-state.dart';
import 'package:youplay/router/youplay-route-information-parser.dart';
import 'package:youplay/router/youplay-route-path.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/ui_selectors.dart';
import 'package:youplay/store/state/ui_state.dart';
import 'package:youplay/store/state/app_state.dart';

class RouteWidgetContainer extends StatelessWidget {
  // BookRouteInformationParser routeInformationParser;

  RouteWidgetContainer({
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
          routeInformationParser:
              BookRouteInformationParser(updatePageType: vm.updatePageType),
          routerDelegate :
              new YouplayRouterDelegate(
                  youplayRoutePath: YouplayRoutePath(
                      pageType: vm.pageType, pageId: vm.pageId, itemId: vm.itemId),
                  updatePageType: vm.updatePageType),

          key: ValueKey('RouteWidget'),
        );
      },
    );
  }
}

class _ViewModel {
  Function(PageType, int?) updatePageType;
  PageType pageType;
  int? pageId;
  int? itemId;

  _ViewModel(
      {required this.updatePageType,
      required this.pageType,
      this.pageId,
      this.itemId});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      updatePageType: (PageType pt, int? pId) => store.dispatch(SetPage(page: pt, pageId: pId)),
      pageType: currentPage(store.state),
      pageId: currentPageId(store.state),
      itemId: currentItemIdSel(store.state),
    );
  }

  bool operator ==(Object other) {
    _ViewModel otherViewModel = other as _ViewModel;
    return (other.pageType == pageType) & (other.pageId == pageId) & (other.itemId == itemId);
  }

  @nonVirtual
  @override
  int get hashCode => pageType.index * (pageId ?? 1) * (itemId ?? 1);

}
