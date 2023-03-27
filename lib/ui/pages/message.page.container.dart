import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/selectors/selector.generalitems.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/messages_pages/util/message_swipe.dart';

import 'game_landing.page.loading.dart';

class MessagePageContainer extends StatefulWidget {
  static final MaterialPage materialPage =
      MaterialPage(key: ValueKey('MessagePageContainer'), child: MessagePageContainer());

  const MessagePageContainer({Key? key}) : super(key: key);

  @override
  State<MessagePageContainer> createState() => _MessagePageContainerState();
}

class _MessagePageContainerState extends State<MessagePageContainer> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      distinct: true,
      builder: (context, vm) {
        int now = new DateTime.now().millisecondsSinceEpoch;
        List<ItemTimes> items = vm.items.where((element) => (element.appearTime < now)).toList(growable: false);
        vm.items.where((element) => (element.appearTime > now)).forEach((itemTime) {
          new Future.delayed(Duration(milliseconds: (itemTime.appearTime - now)), () {
            setState(() {});
          });
        });
        if (vm.item == null) {
          return GameLandingLoadingPage(text: "Even wachten, we proberen deze boodschap te laden...");
        }
        return MessageSwipeWidget(items: items, index: vm.index, openItem: vm.openItem);
      },
    );
  }
}

class _ViewModel {
  List<ItemTimes> items = [];
  GeneralItem? item;
  int index;
  final Function(GeneralItem) openItem;

  _ViewModel({required this.items, required this.item, required this.index, required this.openItem});

  static _ViewModel fromStore(Store<AppState> store) {
    int runId = runIdSelector(store.state.currentRunState);
    // print('index is ${currentGeneralItemIndex(store.state)}');
    return _ViewModel(
        items: itemTimesSortedByTimeReversed(store.state),
        item: currentGeneralItemNew(store.state),
        index: currentGeneralItemIndex(store.state),
        openItem: (GeneralItem item) {
          Future.delayed(Duration(milliseconds: 250)).then((value) => item.openItemAfterTap(store, runId));
        });
  }

  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is _ViewModel && (other.item?.itemId == item?.itemId);
  }

  @override
  int get hashCode => item?.itemId ?? -1;
}
