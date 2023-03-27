import 'package:flutter/material.dart';
import 'package:youplay/models/general_item/narrator_item.dart';
import 'package:youplay/ui/components/appbar/themed-appbar.container.dart';
import 'package:youplay/ui/components/cards/narrator-content-card.text.dart';
import 'package:youplay/ui/components/messages/chapter/chapter-widget.container.dart';
import 'package:youplay/ui/components/messages/message-background.widget.container.dart';
import 'package:youplay/ui/components/next_button/next_button.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

import '../messages/chapter/chapter-widget.dart';

class NarratorWidget extends StatelessWidget {
  final NarratorItem item;

  NarratorWidget({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: ThemedAppbarContainer(title: item.title, elevation: true),
        body: WebWrapper(
            child: ChapterWidgetContainer(
          child: MessageBackgroundWidgetContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Text("top"),

                Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 12),
                    child: NarratorContentCardText(
                      title: item.heading,
                      text: item.richText,
                      button: NextButtonContainer(item: item),
                    ))
              ],
            ),
          ),
        )));
  }
}
