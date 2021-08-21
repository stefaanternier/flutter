import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:youplay/screens/general_item/util/messages/components/themed_app_bar.viewmodel.dart';
import 'package:youplay/store/state/app_state.dart';

class ThemedAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;
  bool elevation = true;
  Color color;

  ThemedAppBar(
      {Key? key, required this.title, this.elevation = true, required this.color})
      : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return new AppBar(
        backgroundColor: color,
        centerTitle: true,
        elevation: this.elevation ? null : 0.0,
        title: new Text(title));
  }
}
