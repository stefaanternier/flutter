import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youplay/screens/game/message_view.dart';
import 'package:youplay/store/state/ui_state.dart';

class ToggleViewButton extends StatelessWidget {

  MessageView view;
  Function() togglePress;

  ToggleViewButton({
    required this.view,
    required this.togglePress,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData iconData = Icons.list;
    switch(view) {
      case MessageView.mapView:
        iconData = FontAwesomeIcons.mapMarkedAlt;
    }
    return IconButton(
      icon: new Icon(
          iconData,
          color: Colors.white),
      tooltip: 'Navigate to map mode',
      onPressed: togglePress
          // () {
        // currentGameViewModel.dispatchToggleMessageView();

      // }
      ,
    );
  }
}

