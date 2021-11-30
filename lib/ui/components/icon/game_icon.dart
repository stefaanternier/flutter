import 'package:flutter/material.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/util/extended_network_image.dart';

class GameIcon extends StatelessWidget {

  Game? game;
  String? iconPath;
  double height;

  GameIcon({
    this.game,
    this.iconPath,
    required this.height,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (game == null || iconPath == null) {
      return CircularProgressIndicator(
        key: ValueKey('gameiconprogress:${game?.gameId}'),
      );
    }
    return Stack(alignment: const Alignment(-0.5, 0.9), children: [
      SizedBox(
        width: this.height,
        height: this.height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Container(
            decoration: getBoxDecoration(iconPath),


          ),
        ),
      ),
      Text(
        '${game!.iconAbbreviation}',
        style: TextStyle(
            fontWeight: FontWeight.w800, fontSize: 22, color: Colors.white),
      )
    ]);
  }
}

