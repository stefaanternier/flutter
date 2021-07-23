import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

class WebWrapper extends StatelessWidget {
  final Widget child;

  const WebWrapper({
    required this.child,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (UniversalPlatform.isWeb) {
      return Container(
        alignment: Alignment.center,
        child: Container(

            constraints: BoxConstraints(maxHeight: 1280, maxWidth: 720),
            child:child),
      );


    }
    return child;
  }
}
