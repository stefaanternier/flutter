import 'package:flutter/material.dart';
import 'package:youplay/screens/components/login/login_screen.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.container.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.dart';

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
    return Scaffold(
      drawer: ARLearnNavigationDrawerContainer(),
      appBar: new AppBar(
          centerTitle: true,
          title: new Text(AppLocalizations.of(context).translate('library.library'),
              style: new TextStyle(color: Colors.white))),
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
    );
  }

  @override
  void initState() {
    widget.init();
  }
}
