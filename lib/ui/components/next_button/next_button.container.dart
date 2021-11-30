import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/store/actions/current_run.action.actions.dart';
import 'package:youplay/localizations.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/current-run.items.selectors.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/next_button/next_button.dart';

class NextButtonContainer extends StatefulWidget {
  final GeneralItem item;

  NextButtonContainer({required this.item, Key? key}) : super(key: key);

  @override
  _NextButtonContainerState createState() => _NextButtonContainerState();
}

class _NextButtonContainerState extends State<NextButtonContainer> {
  Timer? _timer;

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    int now = new DateTime.now().millisecondsSinceEpoch;

    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) =>
          _ViewModel.fromStore(store, widget.item, context),
      builder: (context, vm) {
        if (((vm.nextItem?.lastModificationDate??0) - now) > 0) {
          _timer?.cancel();
          _timer = new Timer(const Duration(milliseconds: 1000), () {
            setState(() {
            });
          });
        }
        return NextButton(
            visible: vm.buttonVisible,
            buttonText: vm.buttonText,
            pressButton: () {
              vm.buttonPressed(context);
            },
            color: vm.color);
      },
    );
  }
}

class _ViewModel {
  // Function(BuildContext) buttonPressed;

  String buttonText;
  Color color;
  List<ItemTimes> moreRecentGames;
  Store<AppState> store;
  GeneralItem item;
  GeneralItem? nextItem;
  _ButtonAction? buttonAction;
  Run? currentRun;

  _ViewModel(
      {
      // required this.buttonPressed,
      required this.color,
      required this.buttonText,
      required this.moreRecentGames,
      required this.store,
      required this.item,
        this.nextItem,
      this.buttonAction,
      this.currentRun});

  static _ViewModel fromStore(
      Store<AppState> store, GeneralItem item, BuildContext context) {
    String text = item.description;
    if (text.contains("::")) {
      int index = text.indexOf("::");
      text = text.substring(0, index);
    } else if (text == '') {
      text = AppLocalizations.of(context).translate('screen.proceed');
    }

    return _ViewModel(
        store: store,
        moreRecentGames: moreRecentThanCurrentItem(store.state),
        color: itemColor(store.state),
        buttonText: text,
        item: item,
        nextItem: nextItemObject(store.state),
        buttonAction: _ButtonAction.fromItem(item),
        currentRun: currentRunSelector(store.state.currentRunState));
  }

  buttonPressed(BuildContext context) {
    if (buttonAction != null) {
      if (buttonAction!.isToMap()) {
        if (item != null) {
          store.dispatch(
              new SetMessageViewAction(messageView: 3)//MessageView.mapView
          );
        }

        // Navigator.pop(context);
        return true;
      }
      if (buttonAction!.isToList()) {
        store.dispatch(
            new SetMessageViewAction(messageView: 2)
        );
        // store.dispatch(new ToggleMessageViewAction(
        //     gameId: item.gameId, messageView: MessageView.listView));

        // Navigator.pop(context);
        return true;
      }
      if (buttonAction!.isToItem()) {
        store.dispatch(SetCurrentGeneralItemId(buttonAction!.getItemId()));
        return true;
      }
    } else {
      int? nextItemInt = firstNewItemId;
      if (nextItemInt != null) {
        if (amountOfNewItems > 1) {
          Navigator.pop(context);
          return true;
        } else {
          if (currentRun != null && currentRun!.runId != null) {
            store.dispatch(new ReadItemAction(
                runId: currentRun!.runId!, generalItemId: nextItemInt));
          }
          store.dispatch(SetCurrentGeneralItemId(nextItemInt));
          return true;
        }
      }
    }
    return false;
  }

  bool get buttonVisible {
    return amountOfNewItems != 0;
  }

  int get amountOfNewItems {
    int now = new DateTime.now().millisecondsSinceEpoch;
    return moreRecentGames
        .where((item) => item.appearTime < now)
        .toList()
        .length;
  }

  int? get firstNewItemId {
    int now = new DateTime.now().millisecondsSinceEpoch;
    int index = moreRecentGames.lastIndexWhere((item) => item.appearTime < now);
    return (index == -1) ? null : moreRecentGames[index].generalItem.itemId;
  }
}

class _ButtonAction {
  late String to;
  late String action;

  _ButtonAction(String fullAction) {
    int index = fullAction.indexOf(":");
    if (index < 0) {
      this.to = fullAction;
      this.action = "";
    } else {
      this.to = fullAction.substring(0, index);
      this.action = fullAction.substring(index + 1);
    }
  }

  @override
  String toString() {
    // TODO: implement toString
    return this.to + " -- " + action;
  }

  bool isToMap() {
    return this.to == 'toMap';
  }

  bool isToList() {
    return this.to == 'toList';
  }

  bool isToItem() {
    return this.to == 'to';
  }

  int getItemId() {
    return int.parse(action);
  }

  static _ButtonAction? fromItem(GeneralItem item) {
    if (item.description != null && item.description.contains("::")) {
      int index = item.description.indexOf("::");
      String action = item.description.substring(index + 2);
      return new _ButtonAction(action);
    }
    return null;
  }
}
