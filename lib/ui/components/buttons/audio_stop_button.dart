import 'package:flutter/material.dart';

class AudioStopButton extends StatelessWidget {
  final Function() onTap;
  AudioStopButton({
    required this.onTap,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        ClipOval(
          child: Material(
            color: Colors.white, // button color
            child: InkWell(
              splashColor: Colors.red, // inkwell color
              child: SizedBox(
                  width: 94,
                  height: 94,
                  child: Icon(
                    Icons.stop,
                    size: 50,
                  )),
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}
