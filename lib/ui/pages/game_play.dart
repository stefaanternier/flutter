import 'package:flutter/material.dart';
import 'package:youplay/ui/components/game_play/message_list.container.dart';
import 'package:youplay/ui/components/game_play/toggle_view_button.container.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

class GamePlay extends StatelessWidget {
  Color color;
  String title;

  GamePlay({
    required this.color, required this.title, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('max view is $maxView');
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
                 [ToggleViewButtonContainer()]),
        body: WebWrapper(
            child: MessagesViewContainer()));
  }
}
