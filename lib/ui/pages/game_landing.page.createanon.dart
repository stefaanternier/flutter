import 'package:flutter/material.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

import '../../localizations.dart';

class GameLandingCreateAnonSessionWaitingPage extends StatefulWidget {
  final Function init;
  GameLandingCreateAnonSessionWaitingPage({required this.init, Key? key}) : super(key: key);

  @override
  _GameLandingCreateAnonSessionWaitingPageState createState() => _GameLandingCreateAnonSessionWaitingPageState();
}

class _GameLandingCreateAnonSessionWaitingPageState extends State<GameLandingCreateAnonSessionWaitingPage> {


  @override
  Widget build(BuildContext context) {
    return WebWrapper(
      child: Scaffold(
        drawer: ARLearnNavigationDrawerContainer(),
        appBar: new AppBar(
            centerTitle: true,
            title: new Image(
              image: new AssetImage(AppConfig().appBarIcon!),
              height: 32.0,
              width: 32.0,
            )
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child:Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                      Container(
                          child: Text(
                            "Anonieme sessie maken ...",
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

  @override
  void initState() {
    widget.init();
  }
}
