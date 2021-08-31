
import 'package:flutter/material.dart';

class VideoPlayerControls extends StatelessWidget {
  final double position;
  final double maxPosition;
  final Function(double) seek;
  final Color color;

  const VideoPlayerControls({
    required this.seek,
    required this.position,
    required this.maxPosition,
    required this.color,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 50,
        left: 50,
        right: 50,
        child: Opacity(
          opacity: 0.9,
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Slider(
                   activeColor: color,
                    value: position,
                    max: maxPosition,
                    onChanged: seek,
                    //     (double val) {
                    //   _controller!.seekTo(
                    //       Duration(milliseconds: val.floor()));
                    // },
                    onChangeEnd: (val) {})
              ],
            ),
          ),
        ));
  }
}
