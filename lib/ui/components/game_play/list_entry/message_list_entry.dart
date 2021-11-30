import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/general_item.dart';

import 'message_list_entry_icon_container.dart';
import 'read_indication.container.dart';

class MessageListEntry extends StatelessWidget {
  GeneralItem item;
  Function onEntryTap;
  int appearTime;
  bool read;

  MessageListEntry(
      {
        required this.read,
        required this.item, required this.onEntryTap, required this.appearTime});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children :[
        if (!read) Positioned(
            left: 0,
            top:0,
            bottom: 0,
            child: ReadIndicationContainer()),
        Padding(
        padding: const EdgeInsets.fromLTRB(0, 17.0, 0, 17.0),
        child:new ListTile(
            leading:
            MessageEntryIconContainer(item: this.item)
            ,
            // onTap: messageViewModel.itemTapAction(item.itemId, context, item.title, item.gameId), //todo

            enabled: item.isSupported,
            title: new Text(
              "${item.title.toUpperCase()}",
              overflow: TextOverflow.ellipsis,
              style: AppConfig().customTheme!.listEntryTitle,
            ),
            subtitle: new Container(
              padding: const EdgeInsets.only(top: 5.0),
              child: item.isSupported
                  ? new Text(
                (item.richText != null) ? "${item.richText}" : "",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: AppConfig().customTheme!.listEntrySubTitle,
              )
                  : new Text(
                "Dit item wordt niet ondersteund in deze modus",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: AppConfig().customTheme!.listEntrySubTitle,
              ),
            ),
            trailing: new Container(
                child: Text(
                  textRowEnd(appearTime, item, context),
                  style: AppConfig().customTheme!.listEntryEndOfLine,
                )),
            onTap: () {
              onEntryTap();
            },
          ),

      ),
    ]
    );
  }

  String textRowEnd(int appearTime, GeneralItem item, BuildContext context) {
    // if ((item.lat != null)) {
    //   return _distanceText(item, context);
    // } else {
      if (appearTime == 0) return "";
      return formatDate(
          DateTime.fromMillisecondsSinceEpoch(appearTime), [HH, ':', nn]);
    // }
  }

//   String _distanceText(GeneralItem item, BuildContext context) {
//     if (item.lat == null || item.lng == null) {
//       return "";
//     }
//     double? distance =
//     LocationContext.of(context)?.distanceFrom(item.lat!, item.lng!);
// //double distance;
//     if (distance == null) return "";
//     String dist = distance.toInt().toString();
//     return "${dist} m";
//   }
}
