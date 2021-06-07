import 'package:youplay/actions/games.dart';
import 'package:youplay/actions/run_actions.dart';
import 'package:youplay/actions/runs.dart';
import 'package:youplay/screens/util/ARLearnContainer.dart';
import 'package:youplay/screens/util/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
//import 'package:youplay/actions/actions.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/screens/game/game_screens_list.dart';
import 'package:youplay/selectors/selectors.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/store/actions/game_messages.actions.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';

class RunActionsViewModel {
  Game currentGame;
  List<Run> runList;
  final Store<AppState> store;
  List<ARLearnAction> actions;

  RunActionsViewModel({this.currentGame, this.runList, this.store, this.actions});

  runTapAction(int index, BuildContext context) {
    return () {
//      store.dispatch(new ApiGameGeneralItems(runList[index].gameId));
//      store.dispatch(new ApiRunsVisibleItems(runList[index].runId));
//
//      store.dispatch(SetCurrentRunAction(runList[index].runId));
//      store.dispatch(new StartRunAction(runId:runList[index].runId));
//
//      Navigator.push(
//        context,
//        MaterialPageRoute(builder: (context) => GameScreen(store)),
//      );
    };
  }
}

class RunActionsScreen extends StatelessWidget {
  RunActionsScreen();

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, RunActionsViewModel>(
        converter: (store) => new RunActionsViewModel(
          currentGame: gameSelector(store.state.currentGameState),
//            currentGame: currentGameSelector(store.state),
            runList: currentRunsSelector(store.state),
            actions: currentRunActionsSelector(store.state),
//            actions: actionsFromServerSelector(store.state),

            store: store),
        builder: (context, runsViewModel) {
          return new Scaffold(
            appBar: AppBar(
              title: Text(" ${runsViewModel.currentGame.title}"),
            ),
            drawer: ARLearnNavigationDrawer(),
            body: ARLearnContainer(
              child: CustomScrollView(
                slivers: <Widget>[
                  RunListHeader(game: runsViewModel.currentGame),
                  SliverFixedExtentList(
                    itemExtent: 56, // I'm forcing item heights
                    delegate: SliverChildBuilderDelegate(
                          (context, index) => RunListTile(
                        title: "${(runsViewModel.actions[index]).action} ${(runsViewModel.actions[index]).getKeyUniqueWithinRun()}",
                        onTap: runsViewModel.runTapAction(index, context),
                      ),
                      childCount: runsViewModel.actions.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
//    );
  }
}

class RunListHeader extends StatelessWidget {
  Game game;
  RunListHeader({this.game});

  @override
  Widget build(BuildContext context) {
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
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                        ),
                        child: new Image(
                          image: new AssetImage(
                              'graphics/myGamesList/gameIcon.png'),
                          height: 48.0,
                          width: 48.0,
                        ),
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
                          'Spel',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        game.title,
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

class RunListTile extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;

  RunListTile({this.onTap, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(4.0),
        color: Colors.white,
        child: new ListTile(
          onTap: this.onTap,
          leading: new Image(
            image: new AssetImage('graphics/myGamesList/gameIcon.png'),
            height: 48.0,
            width: 48.0,
          ),
          title: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                title,
                style: new TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          trailing: const Icon(Icons.keyboard_arrow_right),
        ));
  }
}



class RunListEntry extends StatelessWidget {
  final Run item;
  final Store<AppState> store;

  RunListEntry(this.item, this.store);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(item.title),
      onTap: () {
//        store.dispatch(new ApiGameGeneralItems(item.gameId));
        print("dispatching request screens - place 2");
        store.dispatch(new LoadGameMessagesListRequestAction());
        store.dispatch(new ApiRunsVisibleItems(item.gameId));
      },
    );
  }
}
