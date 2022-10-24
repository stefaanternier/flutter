import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:youplay/ui/components/error/error-notifier.dart';

class WebWrapper extends StatelessWidget {
  final Widget child;

  const WebWrapper({
    required this.child,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (UniversalPlatform.isWeb) {
      return Container(
        alignment: Alignment.topCenter,
        child: Container(
//MediaQuery.of(context).size.height
            //constraints: BoxConstraints(maxHeight: 1280, maxWidth: 720),
            constraints: BoxConstraints(maxHeight: 1280, maxWidth: MediaQuery.of(context).size.height/1280*720),
            child:ErrorNotifier(child: child)),
      );


    }
    return ErrorNotifier(child: child);
  }
}
