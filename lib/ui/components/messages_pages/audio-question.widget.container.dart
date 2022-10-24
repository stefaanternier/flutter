import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/general_item/audio_question.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/actions/current_run.action.actions.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/current_run.picture.actions.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/selectors/selector.generalitems.dart';
import 'package:youplay/store/state/app_state.dart';

import 'audio-question.widget.dart';

class AudioQuestionWidgetContainer extends StatelessWidget {
  final AudioQuestion item;
  const AudioQuestionWidgetContainer({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) =>_ViewModel.fromStore(store, item),
      distinct: true,
      builder: (context, vm) {
        return AudioQuestionWidget(
            item: item,
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

  static _ViewModel fromStore(Store<AppState> store, AudioQuestion item) {
    Run? run = currentRunSelector(store.state.currentRunState);
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
      item: item,
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
