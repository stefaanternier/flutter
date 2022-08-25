import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/util/extended_network_image.dart';

class FeaturedGamesCarrousel extends StatefulWidget {
  final List<Game> games;
  final Function(Game) openGame;

  FeaturedGamesCarrousel({required this.games, required this.openGame, Key? key}) : super(key: key);

  @override
  _FeaturedGamesCarrouselState createState() => new _FeaturedGamesCarrouselState();
}

class _FeaturedGamesCarrouselState extends State<FeaturedGamesCarrousel> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat.yMMMMd(Localizations.localeOf(context).languageCode);
    return SizedBox(
      height: 200, // card height
      child: Center(
        child: widget.games == null
            ? Text("Foto's laden...")
            : PageView.builder(
                itemCount: widget.games.length,
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
                                      decoration: getBoxDecoration('/featuredGames/backgrounds/${widget.games[i].gameId}.png'),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Text(
                                                "${widget.games[i].title}",
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
                                                "${formatter.format(DateTime.fromMillisecondsSinceEpoch(widget.games[i].lastModificationDate))}",
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
                                      widget.openGame(widget.games[i]);
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
