import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/ui/components/appbar/themed-appbar.container.dart';
import 'package:youplay/ui/components/buttons/cust_flat_button.dart';
import 'package:youplay/ui/components/messages_parts/richtext-top.container.dart';
import 'package:youplay/ui/components/next_button/next_button.container.dart';

import '../message-background.widget.container.dart';
import 'audio-results-list.container.dart';


class AudioListRecordings extends StatelessWidget {
  final GeneralItem item;
  final Function pressRecord;

  AudioListRecordings({required this.item, required this.pressRecord, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: ThemedAppbarContainer(title: item.title, elevation: false),
        body: MessageBackgroundWidgetContainer(
            darken: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                RichTextTopContainer(),
                Expanded(child: AudioResultsListContainer()),
                Padding(padding: const EdgeInsets.fromLTRB(46, 8.0, 46, 8), child: NextButtonContainer(item: item)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(46, 8.0, 46, 28),
                  child: CustomFlatButton(
                      title: "Nieuwe opname",
                      icon: FontAwesomeIcons.microphoneAlt,
                      color: Colors.white,
                      onPressed: pressRecord),
                ),
              ],
            )));
  }
}
