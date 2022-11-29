import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class GameScreenshotCard extends StatefulWidget {
  final double cardHeight;
  final double cardWidth;
  final String path;
  final Function missing;
  final int index;

  const GameScreenshotCard(
      {required this.cardHeight,
      required this.cardWidth,
      required this.path,
      required this.missing,
      required this.index,
      Key? key})
      : super(key: key);

  @override
  State<GameScreenshotCard> createState() => _GameScreenshotCardState();
}

class _GameScreenshotCardState extends State<GameScreenshotCard> {
  bool hidden = false;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !hidden,
      child: Card(
          shape: RoundedRectangleBorder(
              side: BorderSide(width: 0, color: Colors.white), borderRadius: BorderRadiusDirectional.circular(20)),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: widget.cardHeight,
                width: widget.cardWidth,
                child: ExtendedImage.network(
                  widget.path,
                  fit: BoxFit.cover,
                  loadStateChanged: (ExtendedImageState state) {
                    switch (state.extendedImageLoadState) {
                      case LoadState.loading:
                      // _controller.reset();
                        return Image.asset(
                          'graphics/loading.gif',
                          fit: BoxFit.cover,
                        );

                      case LoadState.failed:
                        Future.delayed(Duration.zero, () {
                          widget.missing(widget.index);
                        });
                        return Container();
                    }
                  }
                ),
              )
            ],
          )),
    );
  }
}
