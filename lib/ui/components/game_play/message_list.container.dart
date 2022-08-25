
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/store/actions/current_run.action.actions.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/current_run.location.selectors.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/selectors/selector.games.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/state/ui_state.dart';
import 'package:youplay/ui/components/game_play/view/messages_map_view.dart';

import 'view/messages_board_view.dart';
import 'view/messages_list_view.dart';

class MessagesViewContainer extends StatefulWidget {
  @override
  _MessagesViewContainerState createState() => _MessagesViewContainerState();
}

class _MessagesViewContainerState extends State<MessagesViewContainer> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: StoreConnector<AppState, _ViewModel>(
          converter: (Store<AppState> store) => _ViewModel.fromStore(store),
          distinct: true,
          builder: (context, vm) {
            if (vm.isLoading) {
              return Center(
                  child: CircularProgressIndicator(
                key: ValueKey('loadinggameplay'),
              ));
            }
            int now = new DateTime.now().millisecondsSinceEpoch;
            List<ItemTimes> items = vm.items.where((element) => (element.appearTime < now)).toList(growable: false);
            vm.items.where((element) => (element.appearTime > now)).forEach((itemTime) {
              new Future.delayed(Duration(milliseconds: (itemTime.appearTime - now)), () {
                setState(() {});
              });
            });
            if (vm.listType == 2) {
              return MessagesList(
                items: items,
                tapEntry: vm.tapEntry,
              );
            }
            if (vm.listType == 1) {
              print('boardwidth is ${vm.game?.boardWidth ?? 800}');
              print('screenWidth is ${MediaQuery.of(context).size.width}');
              return MetafoorView(
                items: items,
                tapEntry: vm.tapEntry,
                width: vm.game?.boardWidth ?? 800,
                height: vm.game?.boardHeight ?? 860,
                screenHeight:  MediaQuery.of(context).size.height,
                screenWidth:  MediaQuery.of(context).size.width,
                backgroundPath: vm.game?.messageListScreen ?? '/mediaLibrary/Bos/Jungle.png',
              );
            }
            return
                MessagesMapView(
                  items: items,
                  tapEntry: vm.tapEntry,
                );
            // ,
            //     vm.points,
            //     vm.onLocationFound);
          },
        ),
      ),
    );
  }
}

class _ViewModel {
  List<ItemTimes> items = [];
  Function(GeneralItem) tapEntry;
  List<LocationTrigger> points;
  Function onLocationFound;
  Game? game;
  int listType;
  bool isLoading;

  _ViewModel(
      {required this.items,
      required this.tapEntry,
      required this.points,
      required this.onLocationFound,
      required this.listType,
      this.game,
      required this.isLoading});

  static _ViewModel fromStore(Store<AppState> store) {
    int runId = runIdSelector(store.state.currentRunState);
    int lt = store.state.uiState.currentView;
    // int i = lt.index;
    Game? g = currentGame(store.state);
    if (lt == 0 && g != null) {
      store.dispatch(ToggleMessageViewAction(game: g));
    }
    List<ItemTimes> testItems = itemTimesSortedByTime(store.state);
    print('amount of items ${testItems.length}');
    return _ViewModel(
        isLoading: isSyncingActions(store.state) , //todo check if is syncing messages
        listType: lt,
        game: g,
        //store.state.currentGameState.game,
        points: gameLocationTriggers(store.state),
        onLocationFound: (double lat, double lng, int radius) {
          if (runId != -1) {
            store.dispatch(LocationAction(lat: lat, lng: lng, radius: radius, runId: runId));
          }
        },
        items: itemTimesSortedByTime(store.state),
        tapEntry: (GeneralItem item) {
          AppConfig()
              .analytics
              ?.logViewItem(itemId: '${item.itemId}', itemName: '${item.title}', itemCategory: '${item.gameId}');
          store.dispatch(SetCurrentGeneralItemId(item.itemId));
          store.dispatch(new ReadItemAction(runId: runId, generalItemId: item.itemId));
          store.dispatch(new SyncResponsesServerToMobile(
            runId: runId,
            generalItemId: item.itemId,
          ));

          store.dispatch(SetPage(page: PageType.gameItem, gameId: item.gameId, runId: runId, itemId: item.itemId));
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => GeneralItemScreen()),
          // );
        });
  }

  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is _ViewModel
        && (other.items.length == items.length)
        && (other.listType == listType)
        && (other.isLoading == isLoading)
    ;
  }

  @override
  int get hashCode => items.hashCode;
}
