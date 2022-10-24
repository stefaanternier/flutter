import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/general_item/video_object.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/actions/current_run.action.actions.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/selectors/selector.generalitems.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/messages_pages/video-player.widget.dart';

class VideoPlayerWidgetContainer extends StatelessWidget {
  final VideoObjectGeneralItem item;
  const VideoPlayerWidgetContainer({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) =>_ViewModel.fromStore(store, item),
      distinct: true,
      builder: (context, vm) {
        return VideoPlayerWidget(item: item, url: vm.url, onFinishedPlaying: vm.onFinishedPlaying);
      },
    );
  }
}

class _ViewModel {
  final VideoObjectGeneralItem item;
  final String? url;
  final Function() onFinishedPlaying;

  const _ViewModel({required this.item, this.url, required this.onFinishedPlaying});

  static _ViewModel fromStore(Store<AppState> store, VideoObjectGeneralItem item) {
    Run? run = currentRunSelector(store.state.currentRunState);
    String? path = getPath(item);
    return _ViewModel(
        item: item,
        url: path == null ? null : 'https://storage.googleapis.com/${AppConfig().projectID}.appspot.com$path',
        onFinishedPlaying: () {
          if (run != null) {
            store.dispatch(Complete(
              generalItemId: item.itemId,
              runId: run.runId!,
            ));
          }
        });
  }

  static String? getPath(VideoObjectGeneralItem item) {
    String? unencPath;
    if (item.fileReferences != null) {
      unencPath = item.fileReferences!['video']?.replaceFirst('//', '/');
    } else {
      return null;
    }
    if (unencPath == null) {
      return null;
    }
    ;
    int index = unencPath.lastIndexOf("/") + 1;
    if (UniversalPlatform.isIOS) {
      return Uri.encodeComponent(unencPath);
    } else {
      return unencPath.substring(0, index) + Uri.encodeComponent(unencPath.substring(index));
    }
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
