import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/game_theme.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/store/selectors/selector.games.dart';
import 'package:youplay/store/selectors/selector.gametheme.dart';
import 'package:youplay/store/selectors/selector.generalitems.dart';
import 'package:youplay/store/state/app_state.dart';
import 'chapter-widget.dart';

class ChapterWidgetContainer extends StatelessWidget {
  final Widget child;

  ChapterWidgetContainer({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      distinct: true,
      builder: (context, vm) {
        if (vm.game.chapters == 0 || vm.item.chapter == null) {
          return child;
        }
        return ChapterWidget(
            chapter: vm.item.chapter ?? 0,
            maxChapters: vm.game.chapters,
            child: child,
            color: vm.itemPrimaryColor ?? vm.gameTheme?.primaryColor ?? AppConfig().themeData!.primaryColor);
      },
    );
  }
}

class _ViewModel {
  Color? itemPrimaryColor;
  GameTheme? gameTheme;
  Game game;
  GeneralItem item;

  _ViewModel({this.itemPrimaryColor, this.gameTheme, required this.game, required this.item});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
        itemPrimaryColor:
            currentGeneralItemNew(store.state) == null ? null : currentGeneralItemNew(store.state)?.primaryColor,
        gameTheme: currentThemeSelector(store.state),
        item: currentGeneralItemNew(store.state) as GeneralItem,
        game: currentGame(store.state) as Game);
  }

  String? getBackground() {
    if (item.fileReferences != null &&
        item.fileReferences!['background'] != null &&
        item.fileReferences!['background'] != '') {
      return item.fileReferences!['background'];
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
