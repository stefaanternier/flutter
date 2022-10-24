

import 'package:flutter/material.dart';
import 'package:youplay/models/general_item.dart';

class MessageSwipeWidget extends StatefulWidget {

  // final Widget child;
  final List<ItemTimes> items;
  final int index;
  final Function(GeneralItem) openItem;

  const MessageSwipeWidget({
    required this.items,
    required this.index,
    required this.openItem,
    // required this.child,
    Key? key}) : super(key: key);

  @override
  State<MessageSwipeWidget> createState() => _MessageSwipeWidgetState();
}

class _MessageSwipeWidgetState extends State<MessageSwipeWidget> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller  = PageController(
      initialPage: widget.index,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      onPageChanged: (int i) {
        widget.openItem(widget.items[i].generalItem);
      },
      children: List<Widget>.generate(
      widget.items.length,
          (i) => widget.items[i].generalItem.buildPage()
      )
    );

  }
}
