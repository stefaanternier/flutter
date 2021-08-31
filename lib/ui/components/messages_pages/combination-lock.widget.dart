import 'package:flutter/material.dart';
import 'package:youplay/localizations.dart';
import 'package:youplay/models/general_item/combination_lock.dart';
import 'package:youplay/models/general_item/narrator_item.dart';
import 'package:youplay/screens/general_item/util/messages/components/combination_lock_entry.dart';
import 'package:youplay/screens/general_item/util/messages/components/content_card.text.dart';
import 'package:youplay/screens/general_item/util/messages/components/singlechoice/feedback_screen.dart';
import 'package:youplay/screens/general_item/util/messages/components/themed_app_bar.dart';
import 'package:youplay/ui/components/messages/message-background.widget.container.dart';
import 'package:youplay/ui/components/messages_parts/richtext-top.container.dart';
import 'package:youplay/ui/components/next_button/next_button.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

import '../messages/combination_lock/combination-lock.button.container.dart';

class CombinationLockWidget extends StatefulWidget {
  final CombinationLockGeneralItem item;
  Function(String choiceId, bool isCorrect) processAnswerMatch;
  Function() processAnswerNoMatch;

  CombinationLockWidget({
    required this.item, required this.processAnswerMatch, required this.processAnswerNoMatch,
    Key? key}) : super(key: key);

  @override
  _CombinationLockWidgetState createState() => _CombinationLockWidgetState();
}

class _CombinationLockWidgetState extends State<CombinationLockWidget> {
  int _lockLength = 3;
  int _index = -1;
  String _answer = "-";
  bool _numeric = true;

  bool _showFalseFeedback = false;
  bool _showCorrectFeedback = false;

  @override
  Widget build(BuildContext context) {
    if (widget.item.showFeedback) {
      if (_showCorrectFeedback) {
        return FeedbackScreen(
            result: 'correct',
            buttonText: AppLocalizations.of(context).translate('screen.next'),
            item: widget.item,
            feedback: "${widget.item.answers[_index].feedback}",
            // overridePrimaryColor: widget.giViewModel.getPrimaryColor(),
            buttonClick: () {
              // widget.giViewModel.continueToNextItem(context);
            });
      } else if (_showFalseFeedback && _index >= 0 && _index < widget.item.answers.length) {
        return FeedbackScreen(
            result: 'wrong',
            buttonText: 'Ok',
            item: widget.item,
            feedback: "${widget.item.answers[_index].feedback}",
            // overridePrimaryColor: widget.giViewModel.getPrimaryColor(),
            buttonClick: () {
              setState(() {
                _showFalseFeedback = false;
              });
            });
      }
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: ThemedAppBar(title: widget.item.title, elevation: false),
        body: WebWrapper(
            child: MessageBackgroundWidgetContainer(
              darken: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RichTextTopContainer(),
              Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List<CombinationLockEntry>.generate(
                              _lockLength,
                              (i) => CombinationLockEntry(
                                isNumeric: _numeric,
                                index: i,
                                valueChanged: this.setValue,
                              ),
                            )),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(46, 8.0, 46, 8),
                          child: NextButtonContainer(item: widget.item)),
                      Padding(padding: const EdgeInsets.fromLTRB(46, 8.0, 46, 28),
                          child: CombinationLockButtonContainer(
                            unlock: unlock,
                          )),
                    ],
                  ))
            ],
          ),
        )));
  }

  void setValue(val, int index) {
    setState(() {
      if (_answer.length <= index) {
        _answer = _answer + val[0];
      } else {
        _answer = _answer.substring(0, index) + val[0] + _answer.substring(index + 1);
      }
    });
  }

  unlock() {
    int counter = 0;
    bool matchFound = false;
    widget.item.answers.forEach((choice) {
      if (choice.answer.indexOf(_answer) != -1) {
        matchFound = true;
        setState(() {
          _index = counter;
        });
        widget.processAnswerMatch(choice.id, choice.isCorrect);
        setState(() {
          if (choice.isCorrect) {
            _showCorrectFeedback = true;
          } else {
            _showFalseFeedback = true;
          }
        });

        setState(() {
          _answer = "";
          for (int i = 0; i < _lockLength; i++) {
            _answer += _numeric ? "0" : "a";
          }
        });
      } else {
        //todo some kind of catch all?
      }
      counter++;
    });
    if (!matchFound) {
      widget.processAnswerNoMatch();
      setState(() {
        _showFalseFeedback = true;
      });
    }
    counter++;
  }
}
