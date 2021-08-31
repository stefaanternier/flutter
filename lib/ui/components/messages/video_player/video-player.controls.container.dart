import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/messages/video_player/video-player.controls.dart';


class VideoPlayerControlsContainer extends StatelessWidget {

  final Function(double) seek;
  final double position;
  final double maxPosition;


  VideoPlayerControlsContainer({
    required this.seek,
    required this.position,
    required this.maxPosition,
    Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      distinct: true,
      builder: (context, vm) {
        return VideoPlayerControls(
            seek: seek,
            position: position,
            maxPosition: maxPosition,
            color: vm.color
        );
      },
    );
  }
}

class _ViewModel {
  Color color;
  _ViewModel({ required this.color});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
      color: itemColor(store.state),
    );
  }

  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is _ViewModel && (other.color.hashCode == color.hashCode);
  }

  @override
  int get hashCode => color.hashCode;

}