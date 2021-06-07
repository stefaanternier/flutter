import 'package:flutter/material.dart';

class ARLearnMessageHeader extends StatelessWidget {

  ARLearnMessageHeader();

  @override
  Widget build(BuildContext context) {
    return new DecoratedBox(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            fit: BoxFit.fitWidth,
            image: new AssetImage(
                'graphics/gameMessagesHeader.png'),
          ),
          shape: BoxShape.rectangle,
        ));
  }
}

