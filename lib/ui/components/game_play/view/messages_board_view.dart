import 'package:flutter/material.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/util/extended_network_image.dart';
import 'package:youplay/ui/components/game_play/list_entry/message_list_entry_icon_container.dart';
import 'dart:math';

class MetafoorView extends StatefulWidget {
  List<ItemTimes> items = [];
  Function(GeneralItem) tapEntry;
  String backgroundPath;
  double width;
  double height;
  double screenHeight;
  double screenWidth;

  MetafoorView({
    required this.items,
    required this.tapEntry,
    required this.backgroundPath,
    required this.width,
    required this.height,
    required this.screenHeight,
    required this.screenWidth,
    Key? key}): super(key: key);

  @override
  _MetafoorViewState createState() => _MetafoorViewState();
}

class _MetafoorViewState extends State<MetafoorView> {

  late TransformationController _controller;

  @override
  void initState() {
    double heightFactor = (widget.screenHeight-80) / (widget.height);
    double widthFactor = widget.screenWidth / widget.width;
    // print('height is ${widget.height} ${widget.screenHeight} ${heightFactor}') ;
    // print('height is ${widget.width} ${widget.screenWidth}  ${widthFactor}');
    _controller = TransformationController();
    _controller.value = Matrix4.identity() * max(heightFactor, widthFactor);
    super.initState();
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: InteractiveViewer(
        transformationController: _controller,
        maxScale: 5,
         minScale: 0.1,
         constrained: false,
        child: Center(
          child: Stack(
              children: [
            SizedBox(
              width: widget.width,
              height: widget.height,
              child: Container(
                decoration: getBoxDecoration(this.widget.backgroundPath),
              ),
            ),
          ]..addAll(widget.items.map((item) {

            return Positioned(
                    height: 50,
                    width: 50,
                    left: ((item.generalItem.authoringX??15) - 19),
                    top: ((item.generalItem.authoringY??15) - 19),
                    child: GestureDetector(
                        onTap: () {
                          this.widget.tapEntry(item.generalItem);
                        },
                        child: MessageEntryIconContainer(
                            read: item.read,
                            item: item.generalItem)),
                  );}

              ))),
        ),
      ),
    );
  }
}
