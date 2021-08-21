import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ToggleViewButton extends StatelessWidget {

  int view;
  int nextView;
  Function() togglePress;

  ToggleViewButton({
    required this.view,
    required this.nextView,
    required this.togglePress,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData iconData = Icons.list;
    String toolTip = "";
    switch(nextView) {
      case 2:
        iconData = Icons.list;
        toolTip = "naar lijst modus";
        break;
      case 3:
        iconData = FontAwesomeIcons.mapMarkedAlt;
        toolTip = "naar kaart modus";
        break;
      case 1:
        iconData = FontAwesomeIcons.chessBoard;
        toolTip = "naar bord modus";
        break;
    }
    return IconButton(
      icon: new Icon(
          iconData,
          color: Colors.white),
      tooltip: toolTip,
      onPressed: togglePress
          // () {
        // currentGameViewModel.dispatchToggleMessageView();

      // }
      ,
    );
  }
}

