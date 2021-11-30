import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/general_item/scan_tag.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/selectors/selectors.dart';
import 'package:youplay/store/actions/current_run.action.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/messages_pages/scan-tag.widget.dart';

class ScanTagWidgetContainer extends StatelessWidget {
  const ScanTagWidgetContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store, context),
      builder: (context, vm) {
        return ScanTagWidget(
            item: vm.item,
          onResult: vm.onResult,
        );
      },
    );
  }
}

class _ViewModel {
  ScanTagGeneralItem item;
  final Function(String) onResult;

  _ViewModel({
    required this.item,
    required this.onResult
  });

  static _ViewModel fromStore(Store<AppState> store, BuildContext context) {
    ScanTagGeneralItem _item = currentGeneralItem(store.state) as ScanTagGeneralItem;
    return _ViewModel(
      item: _item ,
      onResult: (String qrCode) {
        Run? run = currentRunSelector(store.state.currentRunState);
        store.dispatch(QrScannerAction(
            generalItemId: _item.itemId,
            runId: run!.runId!,
            qrCode: qrCode));
        new Future.delayed(const Duration(milliseconds: 200), () {

          int? itemId = nextItemWithTag(qrCode)(store.state);
          if (itemId != null) {
            if (run.runId != null) {
              store.dispatch(
                  new ReadItemAction(runId: run.runId!, generalItemId: itemId));
            }
            store.dispatch(SetCurrentGeneralItemId(itemId));
          } else {

          }
        });
      }
    );
  }
}
