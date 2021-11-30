import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RunPlayIcon extends StatelessWidget {
  final Color color;
  const RunPlayIcon({required this.color, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 44,
      child: ClipOval(
        child: Material(
          color: color, // button color
          child: InkWell(
            splashColor: color,
            child: SizedBox(
                width: 44,
                height: 44,
                child: Icon(
                  FontAwesomeIcons.play,
                  size: 15,
                  color: Colors.white,
                )),

          ),
        ),
      ),
    );
  }
}
