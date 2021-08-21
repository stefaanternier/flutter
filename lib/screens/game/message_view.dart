// import 'package:youplay/config/app_config.dart';
// import 'package:youplay/models/general_item.dart';
// import 'package:youplay/screens/ui_models/message_view_model.dart';
// import 'package:youplay/screens/util/icons_helper.dart';
// import 'package:youplay/screens/util/location/context2.dart';
// import 'package:date_format/date_format.dart';
// import 'package:flutter/material.dart';
//
// class MessagesView extends StatelessWidget {
//   //currentGeneralItems
//
//   MessageViewModel messageViewModel;
//
//   MessagesView({required this.messageViewModel});
//
//   @override
//   Widget build(BuildContext context) {
// //
//
//     return new ListView.separated(
//       separatorBuilder: (context, index) => Divider(
//         height: 2,
//         color: Colors.black,
//       ),
//       itemCount: this.messageViewModel.items.length,
//       itemBuilder: (context, i) => new Column(
//         children: <Widget>[
//           new ListTile(
//             leading: new ClipOval(
//                 child: Container(
//               padding: const EdgeInsets.all(8.0),
//               decoration: BoxDecoration(
// //                  color: Theme.of(context).primaryColor,
//                   color: this.messageViewModel.getPrimaryColor(),
//                   image: new DecorationImage(
//                       fit: BoxFit.cover,
//                       image: new NetworkImage(
//                           "https://storage.googleapis.com/${AppConfig().projectID}.appspot.com/game/${this.messageViewModel.items[i].generalItem.gameId}/generalItems/${this.messageViewModel.items[i].generalItem.itemId}/icon.png"))),
//               child: new Icon(
//                   getIconUsingPrefix(
//                       name:
//                           this.messageViewModel.items[i].generalItem.getIcon()),
//                   size: 30,
//                   color: Theme.of(context).backgroundColor),
//             )),
//             onTap: messageViewModel.itemTapAction(i, context),
//             title: new Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 new Flexible(
//                     child: new Text(
//                   "${this.messageViewModel.items[i].generalItem.title}",
//                   overflow: TextOverflow.ellipsis,
//                   style: new TextStyle(fontWeight: FontWeight.bold),
// //                          style: Theme.of(context).textTheme.body2,
//                 )),
//                 new Text(
//                   textRowEnd(this.messageViewModel.items[i], context),
// //                  "${formatDate(DateTime.fromMillisecondsSinceEpoch(this.messageViewModel.items[i].appearTime), [HH, ':', nn])}",
// //                  "${_distanceText(this.messageViewModel.items[i].generalItem, context)}",
//                   style: new TextStyle(color: Colors.grey, fontSize: 14.0),
//                 ),
//               ],
//             ),
//             subtitle: new Container(
//               padding: const EdgeInsets.only(top: 5.0),
//               child: new Text(
//                 (this.messageViewModel.items[i].generalItem.richText != null)
//                     ? "${this.messageViewModel.items[i].generalItem.richText}"
//                     : "",
//                 //"TEST ${this.messageViewModel.items[i].appearTime}",
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 1,
//                 style: new TextStyle(color: Colors.grey, fontSize: 15.0),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   String textRowEnd(ItemTimes item, BuildContext context) {
//     if (item.generalItem.showOnMap == false && (item.generalItem.lat != null)) {
//       return _distanceText(item.generalItem, context);
//     } else {
//       if (item.appearTime == 0) return "";
//       return formatDate(
//           DateTime.fromMillisecondsSinceEpoch(item.appearTime), [HH, ':', nn]);
//     }
//   }
//
//   String _distanceText(GeneralItem item, BuildContext context) {
//     if (item.lat == null || item.lng == null) {
//       return "";
//     }
//     double? distance =
//         LocationContext.of(context)?.distanceFrom(item.lat!, item.lng!);
// //double distance;
//     if (distance == null) return "";
//     String dist = distance.toInt().toString();
//     return "${dist} m";
//   }
// }
