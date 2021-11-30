import 'package:flutter/material.dart';
import 'package:youplay/localizations.dart';
import 'package:youplay/models/general_item/single_choice.dart';
import 'package:youplay/screens/general_item/util/messages/components/singlechoice/feedback_screen.dart';
import 'package:youplay/screens/general_item/util/messages/components/themed_app_bar.dart';
import 'package:youplay/ui/components/cards/multiple_choice_card.dart';
import 'package:youplay/ui/components/messages/message-background.widget.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

class MultipleChoiceWidget extends StatefulWidget {
  final MultipleChoiceGeneralItem item;
  Function(String) submit;
  Function() submitCorrectAnswer;
  Function() submitWrongAnswer;
  Function() proceedToNextItem;
  MultipleChoiceWidget({required this.item,
    required this.submit,
    required this.submitCorrectAnswer,
    required this.submitWrongAnswer,
    required this.proceedToNextItem, Key? key}) : super(key: key);

  @override
  _MultipleChoiceWidgetState createState() => _MultipleChoiceWidgetState();
}

class _MultipleChoiceWidgetState extends State<MultipleChoiceWidget> {

  Map<String, bool> _selected = new Map();
  bool _showFalseFeedback = false;
  bool _showCorrectFeedback = false;
  String? wrongFeedback;
  String? correctFeedback;

  @override
  initState() {
    super.initState();
    widget.item.answers.forEach((choice) {
      _selected[choice.id] = false;
      if (choice.isCorrect) {
        correctFeedback = choice.feedback;
      } else {
        wrongFeedback = choice.feedback;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showCorrectFeedback) {
      return FeedbackScreen(
        result: 'correct',
        buttonText: AppLocalizations.of(context).translate('screen.next'),
        item: widget.item,
        feedback: "$correctFeedback",
        // overridePrimaryColor: widget.giViewModel.getPrimaryColor(),
        buttonClick: widget.proceedToNextItem,
        );
    } else if (_showFalseFeedback) {
      return FeedbackScreen(
          result: 'wrong',
          buttonText: 'Ok',
          item: widget.item,
          feedback: "$wrongFeedback",
          buttonClick: () {
            setState(() {
              _showFalseFeedback = false;
            });
          });
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: ThemedAppBar(title: widget.item.title, elevation: true),
        body: WebWrapper(
            child: MessageBackgroundWidgetContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Opacity(
                        opacity: 0.9,
                        child: Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                            child: MultipleChoicesCard(
                                text : widget.item.text,
                                buttonText: (widget.item.description != '') ? widget.item.description : AppLocalizations.of(context).translate('screen.proceed'),
                                answers: widget.item.answers,
                                selected: _selected,
                                changeSelection: (bool value, int i, String id) {
                                  setState(() {
                                    _selected[widget.item.answers[i].id] = value;
                                  });
                                },
                                buttonVisible: this.answerGiven(),
                                submitPressed: submitPressed
                            )))
                  ],
              ),
            )));
  }

  submitPressed() {
    bool correct = true;
    _selected.forEach((answerId, value) {
      if (value) {
        widget.submit(answerId);
      }
    });
    widget.item.answers.forEach((choiceAnswer) {
      if (choiceAnswer.isCorrect != _selected[choiceAnswer.id]) {
        correct = false;
      }
    });

    if (correct) {
      widget.submitCorrectAnswer();
      print('submit correct answer');
      setState(() {
        if (widget.item.showFeedback)  _showCorrectFeedback = true;
      });
    } else {
      print('submit wrong answer');
      widget.submitWrongAnswer();
      setState(() {
        if (widget.item.showFeedback)  _showFalseFeedback = true;
      });
    }
    if (!widget.item.showFeedback) {
      widget.proceedToNextItem();
      // new Future.delayed(const Duration(milliseconds: 100)).then((value) {
      //   if (!widget.giViewModel.continueToNextItem(context)) {
      //     Navigator.pop(context); //todo do not pop
      //   }
      // });
    }
  }

  bool answerGiven() {
    var returnValue = false;
    _selected.forEach((id, b) {
      if (b) {
        returnValue = true;
      }
    });
    return returnValue;
  }
}
