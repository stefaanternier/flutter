import 'package:flutter/material.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/util/extended_network_image.dart';

import 'game_screenshot_carrousel_card.dart';

class GameScreenshotCarrousel extends StatefulWidget {
  final int gameId;
  const GameScreenshotCarrousel({required this.gameId, Key? key}) : super(key: key);

  @override
  State<GameScreenshotCarrousel> createState() => _GameScreenshotCarrouselState();
}

class _GameScreenshotCarrouselState extends State<GameScreenshotCarrousel> {
  int _index = 0;
  List<int> items = <int>[1, 2, 3, 4];


  @override
  Widget build(BuildContext context) {
    double cardHeight = 192 *1.8;
    double cardWidth = 108* 1.8;
    double width = MediaQuery.of(context).size.width;


    double fraction = cardWidth / width;
    return
      SizedBox(
        height: cardHeight + 8,
        child: PageView.builder(
          padEnds: false,
          itemCount: items.length,
          controller: PageController(
              viewportFraction: fraction,
              initialPage: 0
          ),
          onPageChanged: (int index) => setState(() => _index = index),
          itemBuilder: (_, i) {



            return Container(
                margin: i ==0 ? const EdgeInsets.only(left: 20): null,
                child: GameScreenshotCard(
                    cardWidth:cardWidth,
                    cardHeight: cardHeight,
                index: i,
                missing: (index) {
                  setState(() {
                    print('missing index $i');
                    items = items.where((element) => element != items[index]).toList();
                    print('items $items');
                  });
                },
                path: '${AppConfig().storageUrl}/featuredGames/screenshots/${widget.gameId}/screenshot-${items[i]}.png',
                )
            );
          },
        ));
  }
}

class KeepAlive extends StatefulWidget {
  const KeepAlive({required this.data});

  final String data;

  @override
  State<KeepAlive> createState() => _KeepAliveState();
}

class _KeepAliveState extends State<KeepAlive> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(width: 108, height: 192, child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(10)),
        child: Container(color: Colors.green,)),);
  }
}