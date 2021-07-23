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

import 'message_list_entry_icon_container.dart';
import 'message_list_view.viewmodel.dart';

class MetafoorView extends StatelessWidget {
  List<ItemTimes> items = [];
  Function tapEntry;
  String backgroundPath;

  MetafoorView({
    required this.items,
    required this.tapEntry,
    required this.backgroundPath,
    Key? key}): super(key: key);


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
        children: [
      Container(
        decoration: getBoxDecoration(this.backgroundPath),
      ),
    ]..addAll(items.map((item) {
      double x =item.generalItem.relX??1;
      double x2 =width;
      double x3 =x * x2;
      print('pos ${x}  ${x2} ${x3}');
      return Positioned(
              height: 50,
              width: 50,
              left: x3,
              top: (item.generalItem.relY??1)*(height -80),
              child: GestureDetector(
                  onTap: () {
                    this.tapEntry(context, item.generalItem);
                  },
                  child: MessageEntryIconContainer(item: item.generalItem)),
            );}

        )));
  }
}
