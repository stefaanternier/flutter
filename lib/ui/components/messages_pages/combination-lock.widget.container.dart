import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/actions/run_actions.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/general_item/combination_lock.dart';
import 'package:youplay/models/general_item/narrator_item.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/current_run.picture.actions.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/messages_pages/combination-lock.widget.dart';
import 'narrator.widget.dart';

class CombinationLockWidgetContainer extends StatelessWidget {
  const CombinationLockWidgetContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      distinct: true,
      builder: (context, vm) {
        return CombinationLockWidget(item: vm.item,
            processAnswerNoMatch: vm.processAnswerNoMatch,
            processAnswerMatch: vm.processAnswerMatch);
      },
    );
  }
}

class _ViewModel {
  CombinationLockGeneralItem item;
  Function(String choiceId, bool isCorrect) processAnswerMatch;
  Function() processAnswerNoMatch;

  _ViewModel({required this.item, required this.processAnswerMatch, required this.processAnswerNoMatch});

  static _ViewModel fromStore(Store<AppState> store) {
    Run? run = currentRunSelector(store.state.currentRunState);
    GeneralItem item = currentGeneralItem(store.state)!;
    return _ViewModel(
        item: item as CombinationLockGeneralItem,
        processAnswerMatch: (String choiceId, bool isCorrect) {
          if (run != null) {
            store.dispatch(MultiplechoiceAction(mcResponse: Response(run: run, item: item, value: choiceId)));
            store.dispatch(
                MultipleChoiceAnswerAction(generalItemId: item.itemId, runId: run.runId!, answerId: choiceId));
            if (isCorrect) {
              store.dispatch(AnswerCorrect(generalItemId: item.itemId, runId: run.runId!));
            } else {
              store.dispatch(AnswerWrong(generalItemId: item.itemId, runId: run.runId!));
            }
            store.dispatch(SyncFileResponse(runId: run.runId!));
          }
        },
        processAnswerNoMatch: () {
          if (run != null) {
            store.dispatch(AnswerWrong(generalItemId: item.itemId, runId: run.runId!));
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
