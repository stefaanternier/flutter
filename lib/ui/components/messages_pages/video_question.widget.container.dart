import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/general_item/video_question.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/actions/current_run.action.actions.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/current_run.picture.actions.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/selectors/selector.generalitems.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/messages_pages/video_question.widget.dart';

class VideoQuestionWidgetContainer extends StatelessWidget {
  const VideoQuestionWidgetContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      distinct: true,
      builder: (context, vm) {
        return VideoQuestionWidget(
          item: vm.item,
          newRecording: vm.newRecording,
          deleteVideo: vm.deleteVideo,
        );
      },
    );
  }
}

class _ViewModel {
  VideoQuestion item;
  Function(String, int) newRecording;
  Function(Response) deleteVideo;

  _ViewModel({required this.item, required this.newRecording, required this.deleteVideo});

  static _ViewModel fromStore(Store<AppState> store) {
    Run? run = currentRunSelector(store.state.currentRunState);
    GeneralItem item = currentGeneralItemNew(store.state)!;
    return _ViewModel(
        item: item as VideoQuestion,
        newRecording: (String recPath, int durationInMillis) {
          if (run != null) {
            store.dispatch(LocalAction(action: "answer_given", generalItemId: item.itemId, runId: run.runId!));
            store.dispatch(VideoResponseAction(
                videoResponse: VideoResponse(length: durationInMillis, item: item, path: recPath, run: run)));
            store.dispatch(SyncFileResponse(runId: run.runId!));
          }
        },
        deleteVideo: (Response toDelete) {
          print('about to delete ${toDelete.responseId}');
          store.dispatch(DeleteResponseFromServer(responseId: toDelete.responseId!));
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
