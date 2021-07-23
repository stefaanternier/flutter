import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.container.dart';

import 'package:youplay/ui/components/nav/navigation_drawer.dart';
import 'package:youplay/ui/components/game_play/message_list.container.dart';
import 'package:youplay/ui/components/game_play/toggle_view_button.container.dart';

class GamePlay extends StatelessWidget {
  Color color;
  String title;

  GamePlay({required this.color, required this.title, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: ARLearnNavigationDrawerContainer(),
        appBar: AppBar(
            backgroundColor: color,
            title: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                title,
              ),
            ),
            actions:
                UniversalPlatform.isWeb ? null : [ToggleViewButtonContainer()]),
        body: MessageListContainer());
  }
}
