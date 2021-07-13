import 'package:flutter_redux/flutter_redux.dart';
import 'package:youplay/actions/games.dart';
import 'package:youplay/actions/run_actions.dart';
import 'package:youplay/actions/runs.dart';
import 'package:youplay/actions/ui.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/screens/general_item/util/messages/components/themed_app_bar.viewmodel.dart';
import 'package:youplay/screens/util/navigation_drawer.dart';
import 'package:youplay/state/ui_state.dart';
import 'package:flutter/material.dart';

import 'package:youplay/models/game.dart';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:youplay/store/state/app_state.dart';


class RunListHeader extends StatelessWidget {
  Game game;
  RunListHeader({required this.game});

  @override
  Widget build(BuildContext context) {

    return new StoreConnector<AppState, ThemedAppBarViewModel>(
        converter: (store) => ThemedAppBarViewModel.fromStore(store),
        builder: (context, ThemedAppBarViewModel themeModel) {
          //return
          //   SingleChildScrollView(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text("first try")
          //     ],
          //   )
          // );

          return depRender(themeModel);
        });


  }

  Widget depRender(ThemedAppBarViewModel themeModel) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                new Container(
                  margin: new EdgeInsets.only(right: 10.0),
                  child: new ClipRRect(
                      borderRadius: new BorderRadius.circular(8.0),
                      child: Container(
//                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
//                          color: Theme.of(context).primaryColor,
                          color: themeModel.getPrimaryColor(),
                        ),
                        child: Container()
                        // new Image(
                        //     fit: BoxFit.cover,
                        //     height: 50.0,
                        //     width: 50.0,
                        //     image:
                        //     new CachedNetworkImageProvider(
                        //       "https://storage.googleapis.com/${AppConfig().projectID}.appspot.com/game/${game.gameId}/icon.png",
                        //     )
                        // ),

                      )),
                ),
                Expanded(
                  /*1*/
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*2*/
                      Container(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          game.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: themeModel.getPrimaryColor()
                          ),

                        ),
                      ),
                      Text(
                        "Open Universiteit",
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
