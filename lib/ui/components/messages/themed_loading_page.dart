import 'package:flutter/material.dart';
import 'package:youplay/ui/components/messages/message-background.widget.container.dart';

import '../appbar/themed-appbar.container.dart';
import '../web/web_wrapper.dart';

class ThemedLoadingMessage extends StatelessWidget {
  final String message;
  final String title;

  const ThemedLoadingMessage({
    required this.message,
    required this.title,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: ThemedAppbarContainer(title: title, elevation: true),
        body: WebWrapper(
        child: MessageBackgroundWidgetContainer(
        darken: true,
            child: Column(
              children: <Widget>[
                Spacer(flex: 2),
                CircularProgressIndicator(),
                Spacer(flex: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                                message,
                                textAlign: TextAlign.center,
                                maxLines: 4,
                                // overflow: TextOverflow.ellipsis,
                                style: new TextStyle(
                                    color: Colors.white.withOpacity(0.7),

                                    fontSize: 14.0),
                              ),
                          ),
                          ),

                  ],
                ),

                Spacer(flex: 2),
              ],
            )

        )
    ));
  }
}
