import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/general_item/audio_object.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/selectors/selector.generalitems.dart';
import 'audio-player.widget.dart';

class AudioPlayerWidgetContainer extends StatelessWidget {
  const AudioPlayerWidgetContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      distinct: true,
      builder: (context, vm) {
        return AudioPlayerWidget(item: vm.item, url: vm.playUrl);
      },
    );
  }
}

class _ViewModel {
  AudioObjectGeneralItem item;

  _ViewModel({required this.item});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      item: currentGeneralItemNew(store.state) as AudioObjectGeneralItem,
    );
  }

  String? get playUrl {
    if (item.fileReferences != null) {
      String? unencPath = item.fileReferences!['audio']?.replaceFirst('//', '/')?.replaceAll(' ', '%20');
      print('https://storage.googleapis.com/${AppConfig().projectID}.appspot.com${unencPath}');
      if (unencPath != null) {
        return 'https://storage.googleapis.com/${AppConfig().projectID}.appspot.com${unencPath}';
      }
    }
    return null;
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
