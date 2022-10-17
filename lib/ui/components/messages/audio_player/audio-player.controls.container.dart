import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/state/app_state.dart';

import 'audio-player.controls.dart';

class AudioPlayerControlsContainer extends StatelessWidget {

  final Function(double) seek;
  final Function() buttonTap;
  final double position;
  final double maxposition;
  final bool showPlay;

  AudioPlayerControlsContainer({
    required this.seek,
    required this.buttonTap,
    required this.position,
    required this.maxposition,
    required this.showPlay,
    Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      distinct: true,
      builder: (context, vm) {
        return AudioPlayerControls(
            seek: seek,
            buttonTap: buttonTap,
            position: min(position, maxposition),
            maxposition: maxposition,
            showPlay: showPlay,
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