import 'package:flutter/material.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/ui/components/buttons/cust_flat_button.dart';
import 'package:youplay/ui/components/buttons/cust_raised_button.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.container.dart';

import '../../localizations.dart';

class  GameLandingUnAuthPlayAnonPage extends StatelessWidget {
  const  GameLandingUnAuthPlayAnonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // buildGameIcon(context, gameLandingPageModel),
                  // buildGameTitle(context, gameLandingPageModel),
                  Container(
                      child: Text(
                        "Let op, je speelt dit spel anoniem. Dat betekent dat er geen spelstatus wordt bijgehouden.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFFA0ABB5),
                          fontSize: 20.0,
                        ),
                      )),
                  CustomRaisedButton(
                    title: "SPEEL ANONIEM",
//            icon: new Icon(Icons.play_circle_outline, color: Colors.white),
                    onPressed: () {
                      // gameLandingPageModel.tapPlayAnonymously();
                    },
                  ),
                  CustomFlatButton(
                    title: "INLOGGEN",
                    onPressed: () {
                      //TODO..
                      // setState(() {
                      //   showLogin = true;
                      // });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}




