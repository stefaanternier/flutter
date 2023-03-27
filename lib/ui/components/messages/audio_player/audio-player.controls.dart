import 'package:flutter/material.dart';

class AudioPlayerControls extends StatelessWidget {
  final Function(double) seek;
  final Function() buttonTap;
  final double position;
  final double maxposition;
  final bool showPlay;
  Color color;

  AudioPlayerControls({
    required this.seek,
    required this.buttonTap,
    required this.position,
    required this.maxposition,
    required this.showPlay,
    required this.color,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('show play is $showPlay');
    return Stack(
      alignment: const Alignment(0, 0.8),
      children: [
        Positioned(
            left:0,
            right:0,
            top: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: buttonTap,
              child: showPlay ? Icon(
                Icons.play_circle_filled,
                size: 75,
                color: color,
              ) : Icon(Icons.pause_circle_filled,
                  color: color,
                  size: 75),
            )

        ),
        Opacity(
            opacity: 0.9,
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Slider(
                        activeColor: color,
                        value: position,
                        max: maxposition,
                        onChanged: seek,
                        onChangeEnd: (val) {})
                  ],
                ),
              ),
            )),

      ],
    );
  }
}
