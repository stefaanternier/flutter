import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;
import 'package:url_launcher/url_launcher.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

import '../../localizations.dart';

class PlayAppNativePage extends StatefulWidget {
  PlayAppNativePage({Key? key}) : super(key: key);

  @override
  _PlayAppNativePageState createState() => _PlayAppNativePageState();
}

class _PlayAppNativePageState extends State<PlayAppNativePage> {
  String platform = '';

  @override
  void initState() {
    super.initState();
    platform = html.window.navigator.platform?.toLowerCase() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ARLearnNavigationDrawerContainer(),
      appBar: new AppBar(
          centerTitle: true,
          title: new Text(AppLocalizations.of(context).translate('library.library'),
              style: new TextStyle(color: Colors.white))),
      body: WebWrapper(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                      Container(
                          child: Text(
                        "Dit spel kan enkel met de app gespeeld worden... ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFFA0ABB5),
                          fontSize: 20.0,
                        ),
                      )),
                      if (!(platform.contains('ipad') || platform.contains('ipod') || platform.contains('iphone')))
                        GestureDetector(
                          child: Container(
                            width: 227,
                            child: new Image(
                              image: new AssetImage('graphics/playbadge.png'),
                            ),
                          ),
                          onTap: () {
                            launch('https://play.google.com/store/apps/details?id=nl.welten.arlearn3');
                          },
                        ),
                      if (!platform.contains('android'))
                        GestureDetector(
                          child: Container(
                            width: 200,
                            child: new Image(
                              image: new AssetImage('graphics/iosbadge.png'),
                            ),
                          ),
                          onTap: () {
                            launch('https://apps.apple.com/us/app/bibendo/id1457955666');
                          },
                        ),
                      // CustomRaisedButton(
                      //   title: "DOWNLOAD OP PLAY",
                      //   onPressed: () {
                      //     launch('https://play.google.com/store/apps/details?id=nl.welten.arlearn3');
                      //   },
                      // ),
                      // CustomRaisedButton(
                      //   title: "DOWNLOAD VOOR IOS  ",
                      //   onPressed: () {
                      //     launch('https://apps.apple.com/us/app/bibendo/id1457955666');
                      //   },
                      // ),
                    ]))),
          ],
        ),
      ),
    );
  }
}
