import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/screens/components/game_play/message_list_entry.dart';
import 'package:youplay/screens/util/extended_network_image.dart';
import 'package:youplay/screens/util/icons_helper.dart';
import 'package:youplay/screens/util/location/context2.dart';
import 'package:youplay/store/state/app_state.dart';

import '../../../../screens/components/game_play/message_list_entry_icon_container.dart';
import '../../../../screens/components/game_play/message_list_view.viewmodel.dart';

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
