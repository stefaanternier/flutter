//import 'package:youplay/state/library_state.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_redux/flutter_redux.dart';
//import 'package:redux/redux.dart';
//import 'package:youplay/actions/actions.dart';
//import 'package:youplay/state/app_state.dart';
//import 'package:youplay/models/game.dart';
//import 'package:youplay/actions/games.dart';
//
//
//class CategoryScreen extends StatelessWidget {
//  final Store<AppState> store;
//
//  CategoryScreen(this.store);
//
//
//
//  @override
//  Widget build(BuildContext context) {
//    return new StoreProvider(
//        store: store,
//        child: new Scaffold(
//          appBar: AppBar(
//            title: Text("Category"),
//          ),
//          body: Center(
//            child: RaisedButton(
//              onPressed: () {
//                store.dispatch(new AddGameAction(new Game.fromJson(
//                    {"gameId": 1, "language": 'nl', "theme": 1})));
//              },
//              child: new StoreConnector<AppState, List<Category>>(
//                converter: (store) => store.state.library.categories,
//                builder: (context, list) {
//                return GridView.builder(
//                    itemCount: list.length,
//                    gridDelegate:
//                    new SliverGridDelegateWithFixedCrossAxisCount(
//                        mainAxisSpacing: 10.0,
//                        crossAxisSpacing: 10.0,
//                        crossAxisCount: 2),
//                    itemBuilder: (BuildContext context, int index) {
//                      return new CategoryTile(list[index]);
//                    });
//                },
//              ),
//            ),
//          ),
//        ));
//  }
//}
//
//class CategoryTile extends StatelessWidget {
//  Category category;
//  CategoryTile(this.category);
//
//  @override
//  Widget build(BuildContext context) {
//
//      return new  RaisedButton(
//          onPressed: () {
////            Navigator.push(
////              context,
////              MaterialPageRoute(
////                  builder: (context) =>
////                      MyGames(this.store)),
////            );
//          },
//          child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: [Text(this.category.label)]));
//
//  }
//}
