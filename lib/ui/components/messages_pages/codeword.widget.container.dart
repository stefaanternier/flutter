import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/general_item/code_word.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/actions/current_run.action.actions.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/current_run.picture.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/selectors/selector.generalitems.dart';
import 'codeword.widget.dart';

class CodeWordWidgetContainer extends StatelessWidget {
  const CodeWordWidgetContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) =>_ViewModel.fromStore(store, context),
      distinct: true,
      builder: (context, vm) {
        return CodeWordWidget(
            item: vm.item, processAnswerNoMatch: vm.processAnswerNoMatch,
            isNumeric: vm.isNumeric,
            lockLength: vm.lockLength,
            proceedToNextItem: vm.proceedToNextItem,
            processAnswerMatch: vm.processAnswerMatch,
            answer: vm.answer,
        );
      },
    );
  }
}



class _ViewModel {
  CodeWordGeneralItem item;
  Function(String choiceId, bool isCorrect) processAnswerMatch;
  Function() processAnswerNoMatch;
  Function() proceedToNextItem;
  int lockLength;
  bool isNumeric;
  List<Response> fromServer;
  List<String> correctIds;

  _ViewModel({required this.item,
    required this.processAnswerMatch,
    required this.processAnswerNoMatch,
    required this.proceedToNextItem,
    required this.lockLength,
    required this.isNumeric,
    required this.fromServer,
    required this.correctIds,
  });


  static _ViewModel fromStore(Store<AppState> store, BuildContext context) {
    Run? run = currentRunSelector(store.state.currentRunState);
    CodeWordGeneralItem item = currentGeneralItemNew(store.state)! as CodeWordGeneralItem;

    int _lockLength = 0;
    bool _numeric = true;
    List<String> _correctIds = [];

    item.answers.forEach((choice) {
      // _selected[choice.id] = false;
      if (choice.isCorrect) {
        _lockLength = choice.answer.length;
        _numeric = double.tryParse(choice.answer) != null;
        _correctIds.add(choice.id);
      }
    });

    return _ViewModel(
      correctIds: _correctIds,
        fromServer: currentItemResponsesFromServerAsList(store.state),
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

  String? get answer {
    String? returnString = null;
    this.fromServer.forEach((element) {
      if (element.value != null) {
        if (correctIds.indexOf(element.value!) != -1) {
          item.answers.forEach((choice) {
            if (choice.id == element.value) {
              returnString = choice.answer.toUpperCase();
            }
          });
        }
      }
    });
    return returnString;
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
