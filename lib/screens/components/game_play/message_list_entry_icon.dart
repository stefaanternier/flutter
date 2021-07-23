import 'package:flutter/material.dart';
import 'package:youplay/screens/util/icons_helper.dart';

class MessageEntryIcon extends StatelessWidget {
  Color primaryColor;
  String icon;

  MessageEntryIcon({required this.primaryColor, required  this.icon});

  @override
  Widget build(BuildContext context) {
    return new ClipOval(
        child: Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: primaryColor,
      ),
      child: SizedBox(
          width: 30,
          height: 30,
          child: new Icon(getIconUsingPrefix(name: icon), size: 25, color: Colors.white)),
    ));

  }
}
