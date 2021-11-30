import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:youplay/screens/util/extended_network_image.dart';
import 'package:youplay/store/state/app_state.dart';

import 'featured_game_carrousel.viewmodel.dart';

class FeaturedGamesCarrousel extends StatefulWidget {
  FeaturedGamesCarrousel();

  @override
  _FeaturedGamesCarrouselState createState() => new _FeaturedGamesCarrouselState();
}

class _FeaturedGamesCarrouselState extends State<FeaturedGamesCarrousel> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, FeaturedGamesCarrouselViewModel>(
        distinct: true,
        converter: (store) => FeaturedGamesCarrouselViewModel.fromStore(store),
        builder: (context, deviceModel) => _buildPageView(context, deviceModel));
  }

  _buildPageView(BuildContext context, FeaturedGamesCarrouselViewModel featuredGamesModel) {
    final DateFormat formatter = DateFormat.yMMMMd(Localizations.localeOf(context).languageCode);
    return SizedBox(
      height: 200, // card height
      child: Center(
        child: featuredGamesModel.games == null
            ? Text("Foto's laden...")
            : PageView.builder(
                itemCount: featuredGamesModel.games.length,
                controller: PageController(
                    viewportFraction: 0.8,
                  initialPage: 0
                ),
                onPageChanged: (int index) => setState(() => _index = index),
                itemBuilder: (_, i) {
                  return Transform.scale(
                      scale: i == _index ? 1 : 0.9,
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.circular(10)),
                          clipBehavior: Clip.antiAlias,
                          child: Stack(

                              children: <Widget>[
                                Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[

                              Expanded(
                                  flex: 2,
                                  child: Container(
                                      decoration: getBoxDecoration('/featuredGames/backgrounds/${featuredGamesModel.games[i].gameId}.png'),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Text(
                                                "${featuredGamesModel.games[i].title}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold),
                                              )),
                                        ],
                                      ))),


                                Container(
                                    height: 50,
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                              child: Text(
                                                "${formatter.format(DateTime.fromMillisecondsSinceEpoch(featuredGamesModel.games[i].lastModificationDate))}",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                ),
                                              )),
                                        ])),


                              ]),
                                Positioned(
                                  bottom: 25,
                                  right:0,
                                  child: MaterialButton(
                                    onPressed: () {
                                      featuredGamesModel.openGame(featuredGamesModel.games[i]);
                                    },
                                    color: Colors.white,
                                    textColor: Colors.black,
                                    child: Icon(
                                      Icons.play_arrow,
                                      size: 30,
                                    ),
                                    padding: EdgeInsets.all(4),
                                    shape: CircleBorder(),
                                  ),)
                        ])

                          ));
                },
              ),
      ),
    );
  }

}
