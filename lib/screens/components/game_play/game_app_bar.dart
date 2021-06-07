import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/screens/general_item/util/messages/components/themed_app_bar.viewmodel.dart';
import 'package:youplay/state/ui_state.dart';
import 'package:youplay/store/state/app_state.dart';

class GameAppBar extends StatelessWidget {
  Game game;
  MessageView mapView;
  Icon actionIcon;
  Function toggleMapView;

  GameAppBar({this.game, this.mapView, this.toggleMapView});

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ThemedAppBarViewModel>(
        converter: (store) => ThemedAppBarViewModel.fromStore(store),
        builder: (context, ThemedAppBarViewModel themeModel) {
          return AppBar(
            title: Text(
              "${game.title}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            actions: [
              IconButton(
                icon: new Icon(mapView == MessageView.mapView ? Icons.list : Icons.map,
                    color: Colors.white),
                tooltip: 'Navigate to map mode',
                onPressed: () {
                  toggleMapView();
                },
              ),
            ],
          );
//             SliverAppBar(
//               backgroundColor: themeModel.getPrimaryColor(),
//               expandedHeight: 110.0,
//               floating: true,
//               pinned: true,
//               flexibleSpace: FlexibleSpaceBar(
//                 titlePadding: const EdgeInsetsDirectional.only(start: 52, bottom: 16, end: 40),
//                 centerTitle: true,
//                 title: Text(
//                   "${game.title}",
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
// //                          background: new ARLearnMessageHeader(),
//               ),
//               actions: <Widget>[
//                 IconButton(
//                   icon: new Icon(mapView == MessageView.mapView ? Icons.list : Icons.map, color: Colors.white),
//                   tooltip: 'Navigate to map mode',
//                   onPressed: () {
//                     toggleMapView();
//                   },
//                 ),
//               ]);
        });
  }
}
