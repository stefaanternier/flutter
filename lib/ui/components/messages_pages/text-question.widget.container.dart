import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/general_item/text_question.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/actions/current_run.action.actions.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/current_run.picture.actions.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/selectors/selector.generalitems.dart';
import 'package:youplay/store/state/app_state.dart';

import 'text-question.widget.dart';

class TextQuestionWidgetContainer extends StatelessWidget {
  const TextQuestionWidgetContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      distinct: true,
      builder: (context, vm) {
        return TextQuestionWidget(
          item: vm.item,
          submitText: vm.submitText,
        );
      },
    );
  }
}

class _ViewModel {
  TextQuestion item;
  final Function(String) submitText;

  _ViewModel({required this.item, required this.submitText});

  static _ViewModel fromStore(Store<AppState> store) {
    Run? run = currentRunSelector(store.state.currentRunState);
    GeneralItem item = currentGeneralItemNew(store.state)!;
    return _ViewModel(
        item: item as TextQuestion,
        submitText: (String value) {
          if (run != null) {
            store.dispatch(TextResponseAction(textResponse: Response(run: run, item: item, value: value)));
            store.dispatch(LocalAction(action: "answer_given", generalItemId: item.itemId, runId: run.runId!));
            store.dispatch(LocalAction(action: value.toLowerCase().trim().replaceAll(' ', ''), generalItemId: item.itemId, runId: run.runId!));
            store.dispatch(SyncFileResponse(runId: run.runId!));
          }
        });
  }

  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is _ViewModel && (other.item.itemId == item.itemId);
  }

  @override
  int get hashCode => item.itemId;
}
