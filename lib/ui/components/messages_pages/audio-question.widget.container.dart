import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/actions/run_actions.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/general_item/audio_question.dart';
import 'package:youplay/models/general_item/narrator_item.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/current_run.picture.actions.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/state/app_state.dart';
import 'audio-question.widget.dart';
import 'narrator.widget.dart';
import 'picture-question.widget.dart';

class AudioQuestionWidgetContainer extends StatelessWidget {
  const AudioQuestionWidgetContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      distinct: true,
      builder: (context, vm) {
        return AudioQuestionWidget(
            item: vm.item,
            dispatchRecording: vm.newRecording

        );
      },
    );
  }
}

class _ViewModel {
  AudioQuestion item;
  Function(String, int) newRecording;

  _ViewModel({required this.item, required this.newRecording});

  static _ViewModel fromStore(Store<AppState> store) {
    Run? run = currentRunSelector(store.state.currentRunState);
    GeneralItem item = currentGeneralItem(store.state)!;
    return _ViewModel(
      newRecording: (String recPath, int durationInSeconds) {
        if (run != null) {
          store.dispatch(LocalAction(action: "answer_given", generalItemId: item.itemId, runId: run.runId!));
          store.dispatch(AudioResponseAction(
              audioResponse: AudioResponse(
                  length: durationInSeconds, item: item, path: recPath, run: run)));
          store.dispatch(SyncFileResponse(runId: run.runId!));
        }
      },
      item: item as AudioQuestion,
    );
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
