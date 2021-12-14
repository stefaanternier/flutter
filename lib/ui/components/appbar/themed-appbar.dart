import 'package:flutter/material.dart';

class ThemedAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;
  bool elevation = true;
  final Color color;
  final List<Widget>? actions;

  ThemedAppBar(
      {Key? key, required this.title, this.elevation = true, required this.color, this.actions})
      : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return new AppBar(
        backgroundColor: color,
        centerTitle: true,
        elevation: this.elevation ? null : 0.0,
        title: new Text(title),
        actions: actions
    );
  }
}
