import 'package:flutter/material.dart';

class ARLearnContainer extends Container {
  ARLearnContainer({Widget child})
      : super(
            child: child,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('graphics/background.png'),
                fit: BoxFit.cover,
              ),
            ));
}
