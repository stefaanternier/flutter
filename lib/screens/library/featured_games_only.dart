//import 'package:youplay/config/app_config.dart';
////import 'package:youplay/screens/ui_models/store_model.dart';
//import 'package:youplay/screens/util/navigation_drawer.dart';
//import 'package:youplay/state/app_state.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_redux/flutter_redux.dart';
//import 'dart:ui' as ui;
//
//import '../../localizations.dart';
//
////Widget buildFeaturedGamesOnly(BuildContext context) {
////  var lang = Localizations.localeOf(context).languageCode;
////  print(lang);
//////  lang= ui.window.locale.languageCode;
//////  print(AppLocalizations.of(context).translate('library'));
////  return new StoreConnector<AppState, LibraryViewModel>(
////      converter: (store) => LibraryViewModel.fromStore(store),
////      builder: (context, vm) {
////        return new Scaffold(
////          drawer: ARLearnNavigationDrawer(),
////          appBar: new AppBar(
////              centerTitle: true,
////              title: new Text(AppLocalizations.of(context).translate('library.library'),
////                  style: new TextStyle(color: Colors.white))),
////          body: Center(
////              child: Container(
////                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
////                  child:
////                  ListView(
////                    padding: const EdgeInsets.all(8),
////                    children: (AppConfig().featuredGames == null)
////                  ? []
////                  : new List<Card>.generate(
////                  AppConfig().featuredGames[lang].length, (i) {
////                return _featuredGame(
////                    context,
////                    AppConfig().featuredGames[lang][i]['type'],
////                    AppConfig().featuredGames[lang][i]['name'],
////                    AppConfig().featuredGames[lang][i]['description'],
////                    AppConfig().featuredGames[lang][i]['gameId'],
////                    AppConfig().featuredGames[lang][i]['iconUrl'],
////                        () => vm.isAuthenticated
////                        ? vm.onPlayClicked(
////                        AppConfig().featuredGames[lang][i]['runId'],
////                        context) //6058601035595776
////                        : vm.login());
////              })
////                  )
////
//////                  Column(
//////                      children: (AppConfig().featuredGames == null)
//////                          ? []
//////                          : new List<Card>.generate(
//////                              AppConfig().featuredGames.length, (i) {
//////                              return _featuredGame(
//////                                  context,
//////                                  AppConfig().featuredGames[i]['type'],
//////                                  AppConfig().featuredGames[i]['name'],
//////                                  AppConfig().featuredGames[i]['description'],
//////                                  "url",
//////                                  () => vm.isAuthenticated
//////                                      ? vm.onPlayClicked(
//////                                          AppConfig().featuredGames[i]['runId'],
//////                                          context) //6058601035595776
//////                                      : vm.login());
//////                            }))
////
////
////
////              )),
////          //)
////        );
////      });
////}
////
//////}
////
////Card _featuredGame(BuildContext context, String overline, String headline,
////        String body, int gameId, String iconUrl,   Function actionWithClickPlay) =>
////    Card(
////      child: Container(
////        decoration: new BoxDecoration(
////          borderRadius: new BorderRadius.circular(18.0),
////          color: Theme.of(context).dialogBackgroundColor,
////        ),
////        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
////        child: Row(
////          crossAxisAlignment: CrossAxisAlignment.start,
////          children: [
////            Expanded(
////              flex: 4,
////              child: Column(
////                crossAxisAlignment: CrossAxisAlignment.start,
////                children: [
////                  Text("$overline",
////                      style: Theme.of(context).textTheme.overline),
//////                    Flexible(child:
////                  Text("$headline",
////                      style: Theme.of(context).textTheme.headline),
////                  Text("$body",
////                      maxLines: 3,
////                      overflow: TextOverflow.ellipsis,
////                      style: Theme.of(context).textTheme.body1),
//////                    Expanded(
//////                      child:
////                  Container(
////                    alignment: Alignment.bottomLeft,
////                    child:  RaisedButton(
//////                            color: Theme.of(context).accentColor,
//////                            splashColor: Colors.red,
////                      child: Text(
////                        AppLocalizations.of(context).translate('library.start'),
//////                        style: TextStyle(
//////                            color: Colors.white.withOpacity(0.8)),
////                      ),
////                      onPressed: () {
////                        actionWithClickPlay();
////                      },
////                    )
////                  ),
////                ],
////              ),
////            ),
////            Expanded(
////                flex: 2,
////                child: AspectRatio(
////                    aspectRatio: 1,
////                    child: iconUrl !=null? Container(
////                      decoration: new BoxDecoration(
////                          image: new DecorationImage(
////                              fit: BoxFit.cover,
////                              image:  new NetworkImage(
////                                  iconUrl))),
////                      //width: 100,
////
////                      //child: Icon(Icons.gamepad, size: 75), //https://storage.googleapis.com/arlearn-eu.appspot.com/game/6058601035595776/icon.png
////
//////                    child: Image.network(
//////                      'https://storage.googleapis.com/arlearn-eu.appspot.com/game/6058601035595776/icon.png',
//////                    )
////                    ): Container())),
////          ],
////        ),
////      ),
//////      ),
////    );
