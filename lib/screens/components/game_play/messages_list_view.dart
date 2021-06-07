import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/screens/components/game_play/message_list_entry.dart';
import 'package:youplay/screens/util/icons_helper.dart';
import 'package:youplay/screens/util/location/context2.dart';
import 'package:youplay/store/state/app_state.dart';

import 'message_list_view.viewmodel.dart';


class MessagesList extends StatelessWidget {
  List<ItemTimes> items = [];
  Function tapEntry;
  MessagesList({this.items, this.tapEntry});

  @override
  Widget build(BuildContext context) {
    return new ListView.separated(
      separatorBuilder: (context, index) => Divider(
        height: 2,
        color: colorFromHex('#D2DAE2'),
      ),
      itemCount: items.length,
      itemBuilder: (context, i) => new Column(
        children: <Widget>[
          new MessageListEntry(
              item: items[i].generalItem,
              onEntryTap: () {
                this.tapEntry(context, items[i].generalItem);
              }, appearTime: items[i].appearTime)
          // buildListTile(context, items[i].generalItem, items[i].appearTime)
        ],
      ),
    );
  }

  // buildListTile(BuildContext context, GeneralItem item, int appearTime) {
  //  return MessageListEntry
  // }
  String textRowEnd(int appearTime, GeneralItem item, BuildContext context) {
    if ((item.lat != null)) { //item.showOnMap == false &&
      return _distanceText(item, context);
    } else {
      if (appearTime == 0) return "";
      return formatDate(DateTime.fromMillisecondsSinceEpoch(appearTime), [HH, ':', nn]);
    }
  }

  String _distanceText(GeneralItem item, BuildContext context) {
    double distance = LocationContext.of(context)?.distanceFrom(item.lat, item.lng);
//double distance;
    if (distance == null) return "";
    String dist = distance.toInt().toString();
    return "${dist} m";
  }
}

class MessagesListView extends StatefulWidget {


  MessagesListView();

  @override
  _MessagesListViewState createState() => _MessagesListViewState();
}

class _MessagesListViewState extends State<MessagesListView> {


  // LocationContext.around(
  // MessagesListView(),
  // messageViewModel.getLocations(),
  // messageViewModel.onLocationFound);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, MessageListViewModel>(
        converter: (store) => MessageListViewModel.fromStore(store),
        builder: (context, MessageListViewModel messageViewModel) {
          int now = new DateTime.now().millisecondsSinceEpoch;
          List<ItemTimes> items = messageViewModel.items.where((element) => (element.appearTime < now)).toList(growable: false);
          messageViewModel.items.where((element) => (element.appearTime > now)).forEach((itemTime) {
            new Future.delayed(Duration(milliseconds: (itemTime.appearTime - now)), () {
              setState(() {
                print("setting state2");
              });
            });
          });
          return new ListView.separated(
            separatorBuilder: (context, index) => Divider(
              height: 2,
              color: Colors.black,
            ),
            itemCount: items.length,
            itemBuilder: (context, i) => new Column(
              children: <Widget>[
                buildListTile(context, items[i].generalItem,
                    items[i].appearTime, messageViewModel)
              ],
            ),
          );
        });
  }

  buildListTile(
      BuildContext context, GeneralItem item, int appearTime, MessageListViewModel messageViewModel) {
    return new ListTile(
      leading: new ClipOval(
          child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: messageViewModel.getPrimaryColor(),
            image: new DecorationImage(
                fit: BoxFit.cover,
                image: new NetworkImage(
                    "https://storage.googleapis.com/${AppConfig().projectID}.appspot.com/game/${item.gameId}/generalItems/${item.itemId}/icon.png"))),
        child: new Icon(getIconUsingPrefix(name: item.getIcon()), size: 30, color: Theme.of(context).backgroundColor),
      )),
      onTap: messageViewModel.itemTapAction(item.itemId, context, item.title, item.gameId),
      title: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Flexible(
              child: new Text(
            "${item.title}",
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(fontWeight: FontWeight.bold),
//                          style: Theme.of(context).textTheme.body2,
          )),
          new Text(
            textRowEnd(appearTime, item, context),
//                  "${formatDate(DateTime.fromMillisecondsSinceEpoch(this.messageViewModel.items[i].appearTime), [HH, ':', nn])}",
//                  "${_distanceText(this.messageViewModel.items[i].generalItem, context)}",
            style: new TextStyle(color: Colors.grey, fontSize: 14.0),
          ),
        ],
      ),
      subtitle: new Container(
        padding: const EdgeInsets.only(top: 5.0),
        child: new Text(
          // "test ${ new DateTime.fromMicrosecondsSinceEpoch(item.lastModificationDate*1000)}",
          (item.richText != null) ? "${item.richText}" : "",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: new TextStyle(color: Colors.grey, fontSize: 15.0),
        ),
      ),
    );
  }

  String textRowEnd(int appearTime, GeneralItem item, BuildContext context) {
    if ((item.lat != null)) { //item.showOnMap == false &&
      return _distanceText(item, context);
    } else {
      if (appearTime == 0) return "";
      return formatDate(DateTime.fromMillisecondsSinceEpoch(appearTime), [HH, ':', nn]);
    }
  }

  String _distanceText(GeneralItem item, BuildContext context) {
    double distance = LocationContext.of(context)?.distanceFrom(item.lat, item.lng);
//double distance;
    if (distance == null) return "";
    String dist = distance.toInt().toString();
    return "${dist} m";
  }
}
