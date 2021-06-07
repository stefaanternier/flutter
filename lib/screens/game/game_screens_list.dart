import 'package:youplay/screens/game/map_view.dart';
import 'package:youplay/screens/game/message_view.dart';
import 'package:youplay/screens/ui_models/message_view_model.dart';
import 'package:youplay/screens/util/location/context2.dart';
import 'package:youplay/screens/util/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:youplay/store/state/app_state.dart';



//
//class _GameScreenInheritedState extends InheritedWidget {
//  // The data is whatever this widget is passing down.
//  final GameScreenState data;
//
//  _GameScreenInheritedState({
//    Key key,
//    @required this.data,
//    @required Widget child,
//  }) : super(key: key, child: child);
//
//  @override
//  bool updateShouldNotify(_GameScreenInheritedState old) => true;
//}

class GameScreen extends StatefulWidget {
//  final Store<AppState> store;
  bool map;

  GameScreen(this.map);

//  static GameScreenState of(BuildContext context) {
//    return (context.inheritFromWidgetOfExactType(_GameScreenInheritedState)
//    as _GameScreenInheritedState)
//        .data;
//  }


  @override
  GameScreenState createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
//  final Store<AppState> store;

  GameScreenState();

//  @override
//  initState() {
//    super.initState();
//
//  }

  Icon actionIcon = new Icon(
    Icons.map,
    color: Colors.white,
  );

  double lat = 5;
  double lng;

  @override
  Widget build(BuildContext context) {
    if (widget.map) {
      setState(() {
        actionIcon = new Icon(
          Icons.list,
          color: Colors.white,
        );
      });

    }
    return new StoreConnector<AppState, MessageViewModel>(
        converter: (store) => MessageViewModel.fromStore(store),
        builder: (context, MessageViewModel messageViewModel) {
//          messageViewModel.onload();

          Scaffold scaffold = Scaffold(
              drawer: ARLearnNavigationDrawer(),
              body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[

                    SliverAppBar(

                      backgroundColor: messageViewModel.getPrimaryColor(),
                        expandedHeight: 110.0,
                        floating: true,
                        pinned: true,


                        flexibleSpace: FlexibleSpaceBar(
                          titlePadding: const EdgeInsetsDirectional.only(start: 52, bottom: 16, end: 40),
                          centerTitle: true,
                          title: Text(
                            "${messageViewModel.game.title}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
//                          background: new ARLearnMessageHeader(),
                        ),
                        actions: <Widget>[
                          IconButton(
                            icon: actionIcon,
                            tooltip: 'Navigate to map mode',
                            onPressed: () {
                              setState(() {
                                if (this.actionIcon.icon == Icons.map) {
                                  widget.map = true;
                                  this.actionIcon = new Icon(
                                    Icons.list,
                                    color: Colors.white,
                                  );
                                } else {
                                  widget.map = false;
                                  this.actionIcon = new Icon(
                                    Icons.map,
                                    color: Colors.white,
                                  );
                                }
                              });
                            },
                          ),
                        ]),
                  ];
                },
                body: Center(
                    child: this.actionIcon.icon == Icons.list
                        ? MapView(
                            messageViewModel: messageViewModel,
                          )
                        : MessagesView(messageViewModel: messageViewModel)),
              )
//            }
//            )
              );
//          return scaffold;
          return messageViewModel.game.config?.mapAvailable
              ? LocationContext.around(
                  scaffold,
                  messageViewModel.getLocations(),
                  messageViewModel.onLocationFound)
              : scaffold;
        });
  }
}
