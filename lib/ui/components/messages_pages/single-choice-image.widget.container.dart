import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/general_item/single_choice_image.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/selectors/selectors.dart';
import 'package:youplay/store/actions/current_run.action.actions.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/current_run.picture.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/messages_pages/single-choice-image.widget.dart';

class SingleChoiceImageWidgetContainer extends StatelessWidget {
  const SingleChoiceImageWidgetContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) =>_ViewModel.fromStore(store, context),
      distinct: true,
      builder: (context, vm) {
        return SingleChoiceImageWidget(
          item: vm.item,
          submit: vm.submit,
          submitCorrectAnswer: vm.submitCorrectAnswer,
          submitWrongAnswer: vm.submitWrongAnswer,
          proceedToNextItem: vm.proceedToNextItem,
        );
      },
    );
  }
}

class _ViewModel {
  SingleChoiceImageGeneralItem item;
  Function(String) submit;
  Function() submitCorrectAnswer;
  Function() submitWrongAnswer;
  Function() proceedToNextItem;

  _ViewModel({
    required this.item,
    required this.submit,
    required this.submitCorrectAnswer,
    required this.submitWrongAnswer,
    required this.proceedToNextItem,
  });

  static _ViewModel fromStore(Store<AppState> store, BuildContext context) {
    Run? run = currentRunSelector(store.state.currentRunState);
    GeneralItem item = currentGeneralItem(store.state)!;
    return _ViewModel(
        item: item as SingleChoiceImageGeneralItem,
        submit: (String answerId) {
          if (run != null) {
            store.dispatch(
                MultipleChoiceAnswerAction(generalItemId: item.itemId, runId: run.runId!, answerId: answerId));
            store.dispatch(MultiplechoiceAction(mcResponse: Response(run: run, item: item, value: answerId)));
            store.dispatch(SyncFileResponse(runId: run.runId!));
          }
        },
        submitCorrectAnswer: () {
          if (run != null) {
            store.dispatch(AnswerCorrect(generalItemId: item.itemId, runId: run.runId!));
          }
        },
        submitWrongAnswer: () {
          if (run != null) {
            store.dispatch(AnswerWrong(generalItemId: item.itemId, runId: run.runId!));
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
