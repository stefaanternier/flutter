import 'package:flutter/material.dart';
import 'package:youplay/ui/components/icon/current_game_icon.container.dart';
import 'package:youplay/ui/components/icon/game_icon.container.dart';

class GameRunsHeader extends StatelessWidget {
  const GameRunsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(36, 36, 36, 0),
            child: //Container()
                CurrentGameIconContainer(
              height: 68,
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(57, 29, 57, 49),
        child: Row(
          children: <Widget>[
            Flexible(
                child: Text(
              'Kies hieronder een groep om te spelen',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: const Color(0xffa0Abb5),
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ))
          ],
        ),
      )
    ]);
  }
}
