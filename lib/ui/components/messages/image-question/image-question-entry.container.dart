import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/selectors/selector.gametheme.dart';
import 'package:youplay/store/state/app_state.dart';

import 'image-question-entry.dart';

class ImageQuestionEntryContainer extends StatelessWidget {
  final double scale;
  final Function(String, int?) buttonClick;
  final int index;
  final String answerId;
  final String? imagePath;
  final bool isSelected;

  ImageQuestionEntryContainer(
      {required this.scale,
      required this.buttonClick,
      required this.index,
      required this.answerId,
      this.imagePath,
      required this.isSelected,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (context, vm) {
        return ImageQuestionEntry(
          color: vm.getPrimaryColor(),
          scale: scale,
          buttonClick: buttonClick,
          index: index,
          answerId: answerId,
          imagePath: imagePath,
          isSelected: isSelected,
        );
      },
    );
  }
}

class _ViewModel {
  Color? itemPrimaryColor;
  Color? themePrimaryColor;

  _ViewModel({this.itemPrimaryColor, this.themePrimaryColor});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
      itemPrimaryColor: currentGeneralItem(store.state) == null ? null : currentGeneralItem(store.state)?.primaryColor,
      themePrimaryColor: currentGameThemeColor(store.state),
    );
  }

  Color getPrimaryColor() {
    return itemPrimaryColor ?? themePrimaryColor ?? AppConfig().themeData!.primaryColor;
  }
}
