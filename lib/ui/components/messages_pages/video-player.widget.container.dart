import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/general_item/narrator_item.dart';
import 'package:youplay/models/general_item/video_object.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/messages_pages/video-player.widget.dart';
import 'narrator.widget.dart';

class VideoPlayerWidgetContainer extends StatelessWidget {
  const VideoPlayerWidgetContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      distinct: true,
      builder: (context, vm) {
        return VideoPlayerWidget(
            item: vm.item,
          url: vm.url,
            onFinishedPlaying: vm.onFinishedPlaying

        );
      },
    );
  }
}

class _ViewModel {
  final VideoObjectGeneralItem item;
  final String url;
  final Function() onFinishedPlaying;

  const _ViewModel({required this.item, required this.url, required this.onFinishedPlaying});

  static _ViewModel fromStore(Store<AppState> store) {
    VideoObjectGeneralItem item = currentGeneralItem(store.state) as VideoObjectGeneralItem;
    print(' url is https://storage.googleapis.com/${AppConfig().projectID}.appspot.com${getPath(item)}');
    return _ViewModel(
      item: currentGeneralItem(store.state) as VideoObjectGeneralItem,
      url: 'https://storage.googleapis.com/${AppConfig().projectID}.appspot.com${getPath(item)}',
      onFinishedPlaying: () {

      }
    );
  }

  static String getPath(VideoObjectGeneralItem item) {
    String? unencPath;
    if (item.fileReferences != null) {
      unencPath = item.fileReferences!['video']?.replaceFirst('//', '/');
    }
    if (unencPath == null) return '/';

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
