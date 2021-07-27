import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:youplay/screens/components/game_run_overview/list_tile.dart';
import 'package:youplay/screens/general_item/util/messages/components/themed_app_bar.dart';
import 'package:youplay/screens/ui_models/game_runs_overview_model.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/icon/game_icon.container.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

class GameRunsOverviewPage extends StatelessWidget {
  GameRunsOverviewPage();

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, GameRunsOverviewModel>(
        converter: (store) => GameRunsOverviewModel.fromStore(store),
        builder: (context, runsViewModel) {
          return new Scaffold(
              appBar: ThemedAppBar(title: runsViewModel.currentGame?.title??'', elevation: true),
              // AppBar(
              //   title: Text("${runsViewModel.currentGame.title}"),
              //   backgroundColor: runsViewModel?.currentGame?.config?.primaryColor,
              // ),
              drawer: ARLearnNavigationDrawerContainer(),
              body: WebWrapper(
                child: SingleChildScrollView(
                    child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(36, 36, 36, 0),
                            child: GameIconContainer(
                              game: runsViewModel.currentGame,
                              height: 68,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(57, 29, 57, 49),
                        child: Row(
                          children: <Widget>[
                            Flexible(
                                child: Text(
                              'Kies hieronder een groep om te spelen',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: const Color(0xffa0Abb5),
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal),
                            ))
                          ],
                        ),
                      ),
                      buildRunList(runsViewModel),
                      Divider(),
                    ])),
              ));
//          }
        });
//    );
  }

  buildRunList(GameRunsOverviewModel runsViewModel) {
    return Column(
        children: List<Column>.generate(
      runsViewModel.runList.length,
      (index) => Column(
        children: [
          Divider(),
          RunListTile(
              title: "${(runsViewModel.runList[index]).title}",
              lastModificationDate: runsViewModel.runList[index].lastModificationDate,
              onTap: runsViewModel.runTapAction(index)),
        ],
      ),
    ));
  }
}
