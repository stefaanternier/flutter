import 'package:flutter/material.dart';
import 'package:youplay/localizations.dart';
import 'package:youplay/models/general_item/combination_lock.dart';
import 'package:youplay/ui/components/appbar/themed-appbar.container.dart';
import 'package:youplay/ui/components/messages/chapter/chapter-widget.container.dart';
import 'package:youplay/ui/components/messages/combination_lock/combination-lock-entry.dart';
import 'package:youplay/ui/components/messages/feedback-screen/feedback_screen.dart';
import 'package:youplay/ui/components/messages/message-background.widget.container.dart';
import 'package:youplay/ui/components/messages_parts/richtext-top.container.dart';
import 'package:youplay/ui/components/next_button/next_button.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

import '../messages/combination_lock/combination-lock.button.container.dart';

class CombinationLockWidget extends StatefulWidget {
  final CombinationLockGeneralItem item;
  Function(String choiceId, bool isCorrect) processAnswerMatch;
  Function() processAnswerNoMatch;
  int lockLength;
  bool isNumeric;
  final Function() proceedToNextItem;

  CombinationLockWidget(
      {required this.item,
      required this.processAnswerMatch,
      required this.processAnswerNoMatch,
      required this.proceedToNextItem,
      required this.lockLength,
      required this.isNumeric,
      Key? key})
      : super(key: key);

  @override
  _CombinationLockWidgetState createState() => _CombinationLockWidgetState();
}

class _CombinationLockWidgetState extends State<CombinationLockWidget> {
  // int _lockLength = 3;
  int _index = -1;
  String _answer = "-";

  // bool _numeric = true;

  bool _showFalseFeedback = false;
  bool _showCorrectFeedback = false;

  @override
  initState() {
    super.initState();
    if (this._answer == "-") {
      int longest = 0;
      this.widget.item.answers.forEach((choice) {
        if (choice.answer.length > longest) longest = choice.answer.length;
      });
      this._answer = "";
      for (int i = 0; i < longest; i++) {
        if (widget.isNumeric) {
          this._answer += "0";
        } else {
          this._answer += "a";
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print('combination lock widget');
    if (widget.item.showFeedback) {
      if (_showCorrectFeedback) {
        return FeedbackScreen(
            result: 'correct',
            buttonText: AppLocalizations.of(context).translate('screen.next'),
            item: widget.item,
            feedback: "${widget.item.answers[_index].feedback}",
            // overridePrimaryColor: widget.giViewModel.getPrimaryColor(),
            buttonClick: () {
              widget.proceedToNextItem();
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
        appBar: ThemedAppbarContainer(title: widget.item.title, elevation: false),
        body: WebWrapper(

                child: MessageBackgroundWidgetContainer(
          darken: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RichTextTopContainer(),
                   Flexible(
                  flex: 1,

                  child: ChapterWidgetContainer(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List<CombinationLockEntry>.generate(
                              widget.lockLength,
                              (i) => CombinationLockEntry(
                                isNumeric: widget.isNumeric,
                                index: i,
                                valueChanged: this.setValue,
                              ),
                            )),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(46, 8.0, 46, 8),
                          child: NextButtonContainer(item: widget.item)),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(46, 8.0, 46, 28),
                          child: CombinationLockButtonContainer(
                            unlock: unlock,
                          )),
                    ],
                  ))
                   )
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
    setState(() {
      _index = -1;
    });
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
          for (int i = 0; i < widget.lockLength; i++) {
            _answer += widget.isNumeric ? "0" : "a";
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
