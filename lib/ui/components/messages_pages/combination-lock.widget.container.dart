import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/actions/games.dart';
import 'package:youplay/actions/run_actions.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/general_item/combination_lock.dart';
import 'package:youplay/models/general_item/narrator_item.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/selectors/selectors.dart';
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
      converter: (store) =>_ViewModel.fromStore(store, context),
      distinct: true,
      builder: (context, vm) {
        return CombinationLockWidget(
            item: vm.item, processAnswerNoMatch: vm.processAnswerNoMatch,
            isNumeric: vm.isNumeric,
            lockLength: vm.lockLength,
            proceedToNextItem: vm.proceedToNextItem,
            processAnswerMatch: vm.processAnswerMatch);
      },
    );
  }
}



class _ViewModel {
  CombinationLockGeneralItem item;
  Function(String choiceId, bool isCorrect) processAnswerMatch;
  Function() processAnswerNoMatch;
  Function() proceedToNextItem;
  int lockLength;
  bool isNumeric;

  _ViewModel({required this.item,
    required this.processAnswerMatch,
    required this.processAnswerNoMatch,
    required this.proceedToNextItem,
    required this.lockLength,
    required this.isNumeric,
  });


  static _ViewModel fromStore(Store<AppState> store, BuildContext context) {
    Run? run = currentRunSelector(store.state.currentRunState);
    CombinationLockGeneralItem item = currentGeneralItem(store.state)! as CombinationLockGeneralItem;

    int _lockLength = 0;
    bool _numeric = true;
    // String correctAnswer = "";

    item.answers.forEach((choice) {
      // _selected[choice.id] = false;
      if (choice.isCorrect) {
        _lockLength = choice.answer.length;
        _numeric = double.tryParse(choice.answer) != null;
        // correctAnswer = "";
        // for (int i = 0; i < _lockLength; i++) {
        //   correctAnswer += _numeric ? "0" : "a";
        // }
      }
    });

    return _ViewModel(
        item: item,
        isNumeric: _numeric,
        lockLength: _lockLength,
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
        },
        proceedToNextItem: () {
          new Future.delayed(const Duration(milliseconds: 100)).then((value) {
            int amountOfNewItems = amountOfNewerItems(store.state);
            int? nextItemInt = nextItem1(store.state);
            if (nextItemInt != null && amountOfNewItems == 1) {
              if (run?.runId != null) {
                store.dispatch(new ReadItemAction(runId: run!.runId!, generalItemId: nextItemInt));
              }
              store.dispatch(SetCurrentGeneralItemId(nextItemInt));
            } else {
              Navigator.of(context).pop();
            }
          });
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
