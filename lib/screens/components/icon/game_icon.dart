// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/screens/util/extended_network_image.dart';
import 'package:youplay/store/state/app_state.dart';

import 'game_icon.viewmodel.dart';

class GameIcon extends StatelessWidget {
  Game? game;

  double height;

  GameIcon({this.game, this.height = 59});

  @override
  Widget build(BuildContext context) {
    if (game == null) {
      return Container(child: Text('loading..'));
    }
    return new StoreConnector<AppState, GameIconViewModel>(
      distinct: true,
      converter: (store) => GameIconViewModel.fromStore(store, context, this.game!),
      builder: (context, iconModel) => Stack(alignment: const Alignment(-0.5, 0.9), children: [
        Visibility(
            visible: iconModel.iconPath != null,
            child: iconModel.iconPath == null
                ? Container(child : Text(''))
                : buildRoundImage(context, iconModel.iconPath())
            // Image(
            //         height: this.height,
            //     image: buildImage(context, '${iconModel.iconPath()}')
            // )
        ),
        Text(
          '${game!.iconAbbreviation}',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22, color: Colors.white),
        )
      ]),
    );
    // return Container();
  }

  Widget buildRoundImage(BuildContext context, String? iconPath) {
    if (iconPath == null){
      return Container(child: Text('..'));
    }

    return SizedBox(
      width: this.height,
      height: this.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          decoration: getBoxDecoration(iconPath),


        ),
      ),
    );
  }
}


