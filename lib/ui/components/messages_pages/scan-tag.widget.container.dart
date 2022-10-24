import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/general_item/scan_tag.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/actions/current_run.action.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/current_run.qr.selectors.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/messages_pages/scan-tag.widget.dart';

class ScanTagWidgetContainer extends StatelessWidget {
  final ScanTagGeneralItem item;
  const ScanTagWidgetContainer({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store, context, item),
      distinct: true,
      builder: (context, vm) {
        print('before render ${this.item}');
        return ScanTagWidget(
          item: item,
          onResult: vm.onResult,
        );
      },
    );
  }
}

class _ViewModel {
  ScanTagGeneralItem item;
  final Function(String) onResult;

  _ViewModel({required this.item, required this.onResult});


  static _ViewModel fromStore(Store<AppState> store, BuildContext context, ScanTagGeneralItem item) {
    return _ViewModel(
        item: item,
        onResult: (String qrCode) {
          Run? run = currentRunSelector(store.state.currentRunState);
          store.dispatch(QrScannerAction(context: context, generalItemId: item.itemId, runId: run!.runId!, qrCode: qrCode));
          new Future.delayed(const Duration(milliseconds: 200), () {
            int? itemId = nextItemWithTag(qrCode)(store.state);
            if (itemId != null) {
              if (run.runId != null) {
                store.dispatch(new ReadItemAction(runId: run.runId!, generalItemId: itemId));
              }
              store.dispatch(SetCurrentGeneralItemId(itemId));
            } else {
              Navigator.of(context).pop();
            }
          });
        });
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel && runtimeType == other.runtimeType && item.itemId == other.item.itemId;

  @override
  int get hashCode => item.itemId;
}
