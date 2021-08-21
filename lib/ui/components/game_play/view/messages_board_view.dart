import 'package:flutter/material.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/ui/components/game_play/list_entry/message_list_entry_icon_container.dart';
import 'package:youplay/screens/util/extended_network_image.dart';

class MetafoorView extends StatelessWidget {
  List<ItemTimes> items = [];
  Function(GeneralItem) tapEntry;
  String backgroundPath;
  double width;
  double height;

  MetafoorView({
    required this.items,
    required this.tapEntry,
    required this.backgroundPath,
    required this.width,
    required this.height,
    Key? key}): super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center(
      child: InteractiveViewer(
        maxScale: 5,
         minScale: 0.1,
         constrained: false,
        child: Center(
          child: Stack(
              children: [
            SizedBox(
              width: width,
              height: height,
              child: Container(
                decoration: getBoxDecoration(this.backgroundPath),
              ),
            ),
          ]..addAll(items.map((item) {
            return Positioned(
                    height: 50,
                    width: 50,
                    left: ((item.generalItem.authoringX??15) - 19),
                    top: ((item.generalItem.authoringY??15) - 19),
                    child: GestureDetector(
                        onTap: () {
                          this.tapEntry(item.generalItem);
                        },
                        child: MessageEntryIconContainer(item: item.generalItem)),
                  );}

              ))),
        ),
      ),
    );
  }
}
