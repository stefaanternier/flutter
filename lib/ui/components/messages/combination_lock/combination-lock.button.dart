import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CombinationLockButton extends StatelessWidget {
  final Color color;
  final Function() unlock;

  CombinationLockButton({
    required this.color,
    required this.unlock,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ClipOval(
        child: Material(
          color: Colors.white, // button color
          child: InkWell(
            splashColor: color,
            child: SizedBox(
                width: 94,
                height: 94,
                child: Icon(
                  FontAwesomeIcons.unlockAlt,
                  color: color,
                )),
            onTap: unlock,
          ),
        ),
      ),
    ]);
  }
}
