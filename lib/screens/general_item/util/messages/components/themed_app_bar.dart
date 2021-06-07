import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:youplay/screens/general_item/util/messages/components/themed_app_bar.viewmodel.dart';
import 'package:youplay/store/state/app_state.dart';

class ThemedAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;
  bool elevation = true;

  ThemedAppBar(
    {
    Key key, this.title, this.elevation = true
  })  : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ThemedAppBarViewModel>(
        converter: (store) => ThemedAppBarViewModel.fromStore(store),
        builder: (context, ThemedAppBarViewModel themeModel) {
          return new AppBar(
              backgroundColor: themeModel.getPrimaryColor(),
              centerTitle: true,
              elevation: this.elevation ? null : 0.0,
              title: new Text("${title}"));
        });
  }
}
