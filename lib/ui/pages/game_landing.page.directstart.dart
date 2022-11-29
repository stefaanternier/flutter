import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/ui/components/collection/game_screenshot_carrousel.dart';
import 'package:youplay/ui/components/icon/game_icon.container.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

class GameLandingDirectStartPage extends StatelessWidget {
  Game game;
  Function() createRunAndStart;
  Function() close;
  Function() openDev;

  GameLandingDirectStartPage(
      {required this.game, required this.createRunAndStart, required this.openDev, required this.close, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: ARLearnNavigationDrawerContainer(),
      appBar: new AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Color(0xff616161),
              radius: 16,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(Icons.close),
                color: Colors.white,
                onPressed: close,
              ),
            ),
          ),
        ],
      ),
      body: WebWrapper(
        child: ListView(
          padding: EdgeInsets.only(top: 0),
          children: [
            ExtendedImage.network(
              '${AppConfig().storageUrl}/featuredGames/backgrounds/${game.gameId}.png',
              fit: BoxFit.cover,
              cache: true,
              printError: true,
              retries: 5,
              timeRetry: Duration(seconds: 10),
              loadStateChanged: (ExtendedImageState state) {
                switch (state.extendedImageLoadState) {
                  case LoadState.loading:
                    // _controller.reset();
                    return Image.asset(
                      'graphics/loading.gif',
                      fit: BoxFit.cover,
                    );

                  case LoadState.failed:
                    return Image.asset(
                      //new AssetImage('graphics/loading.gif')
                      'graphics/loading.gif',
                      fit: BoxFit.cover,
                    );
                }
              },
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 20),
                    child: Hero(
                      tag: 'gameIcon${game.gameId}',
                      child: GameIconContainer(game: game, height: 100),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*2*/
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            '${game.title.toUpperCase()} ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (game.devTeam != null)
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Container(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                'Ontwikkeld door:',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                ),
                              ),
                            ),
                            Text(
                              "${game.devTeam}",
                              style: TextStyle(
                                color: Colors.grey[500],
                              ),
                            ),
                          ]),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(60, 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26.0),
                            ),
                          ),
                          onPressed: createRunAndStart,
                          child: const Text('OPEN'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            IntrinsicHeight(
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: _buildButtonColumn(Icons.schedule, '${game.playDuration}', 'minuten', context)),
                  const VerticalDivider(
                    width: 30,
                    thickness: 1,
                    indent: 2,
                    endIndent: 2,
                    color: Colors.grey,
                  ),
                  Expanded(child: _buildButtonColumn(Icons.accessibility, '${game.ageSpan}', 'jaar', context)),
                  const VerticalDivider(
                    width: 30,
                    thickness: 1,
                    indent: 2,
                    endIndent: 2,
                    color: Colors.grey,
                  ),
                  Expanded(child: _buildButtonColumn(Icons.star, '${game.amountOfPlays}', 'gespeeld', context)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                "${game.description}",
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ),

            Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: GameScreenshotCarrousel(
                  gameId: game.gameId,
                )),

            if (game.organisationId != null)
              ListTile(
                title: Text("${game.devTeam}"),
                subtitle: Text(
                    'Ontwikkelaar'),
                onTap: openDev,
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            // Container(
            //   padding: const EdgeInsets.all(20),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //     Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            //     Container(
            //       padding: const EdgeInsets.only(bottom: 8),
            //       child: Text(
            //         'Ontwikkeld door:',
            //         style: TextStyle(
            //           color: Colors.grey[500],
            //         ),
            //       ),
            //     ),
            //     Text(
            //       "${game.devTeam}",
            //       style: TextStyle(
            //         color: Colors.grey[500],
            //       ),
            //     ),
            //   ]),
            //     Expanded(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           /*2*/
            //           Container(
            //             padding: const EdgeInsets.only(bottom: 8),
            //             child: Text(
            //               '${game.title.toUpperCase()} ',
            //               style: TextStyle(
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //           ),
            //
            //           ElevatedButton(
            //             style: ElevatedButton.styleFrom(
            //               minimumSize: Size(60, 24),
            //               shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(26.0),
            //               ),
            //             ),
            //             onPressed: createRunAndStart,
            //             child: const Text('OPEN'),
            //           ),
            //         ],
            //       ),
            //     ),
            //     ],
            //   ),
            // ),
            Container(padding: const EdgeInsets.only(bottom: 40))
          ],
        ),
      ),
    );
  }

  Column _buildButtonColumn(IconData icon, String first, String second, BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            first,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            second,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
