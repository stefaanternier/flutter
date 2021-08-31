import 'dart:async';

import 'package:flutter/material.dart';

class VideoPlayerButton extends StatelessWidget {
  final Function() tap;
  final bool play;
  final Color color;

  const VideoPlayerButton({
    required this.tap,
    required this.play,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: Opacity(
      opacity: 1.0,
      child: GestureDetector(
        onTap: () {
          new Timer(Duration(milliseconds: 10), tap);
        },
        child: Icon(
          play ? Icons.pause_circle_filled : Icons.play_circle_filled,
          color: color,
          size: 75,
        ),
      ),
    ));
  }
}
