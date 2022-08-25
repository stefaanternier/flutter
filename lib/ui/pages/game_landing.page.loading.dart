import 'package:flutter/material.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

import '../../localizations.dart';

class GameLandingLoadingPage extends StatelessWidget {
  final String? text;
  final Color? backgroundColor;
  GameLandingLoadingPage({
    this.backgroundColor,
    this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ARLearnNavigationDrawerContainer(),
      backgroundColor: backgroundColor,
      appBar: new AppBar(
          centerTitle: true,
          title: new Text(AppLocalizations.of(context).translate('library.library'),
              style: new TextStyle(color: Colors.white))),
      body: WebWrapper(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child:Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                      CircularProgressIndicator(),
                      Container(

                          child: Text(text ??  "Spel laden ...",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFA0ABB5),
                              fontSize: 20.0,
                            ),
                          ))
                    ]))
            ),
          ],
        ),
      ),
    );
  }
}

// class _GameLandingLoadingPageState extends State<GameLandingLoadingPage> {
//
//
//
//
// }
