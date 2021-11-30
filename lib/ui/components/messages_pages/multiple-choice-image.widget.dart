import 'package:flutter/material.dart';
import 'package:youplay/localizations.dart';
import 'package:youplay/models/general_item/multiple_choice_image.dart';
import 'package:youplay/ui/components/messages/image-question/image_question.dart';
import 'package:youplay/ui/components/messages/feedback-screen/feedback_screen.dart';
import 'package:youplay/ui/components/appbar/themed-appbar.container.dart';
import 'package:youplay/ui/components/messages/message-background.widget.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

class MultipleChoiceImageWidget extends StatefulWidget {
  final MultipleChoiceImageGeneralItem item;
  final Function(String) submit;
  final Function() submitCorrectAnswer;
  final Function() submitWrongAnswer;
  final Function() proceedToNextItem;

  MultipleChoiceImageWidget(
      {required this.item,
        required this.submit,
        required this.submitCorrectAnswer,
        required this.submitWrongAnswer,
        required this.proceedToNextItem,
        Key? key})
      : super(key: key);

  @override
  _MultipleChoiceImageWidgetState createState() => _MultipleChoiceImageWidgetState();
}

class _MultipleChoiceImageWidgetState extends State<MultipleChoiceImageWidget> {
  late Map<String, bool> _selected = new Map();
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
        appBar: ThemedAppbarContainer(title: widget.item.title, elevation: true),
        body: WebWrapper(
            child: MessageBackgroundWidgetContainer(
              child: ImageQuestion( //todo refactor image question
                item: widget.item,
                buttonText: (widget.item.description != '')
                    ? widget.item.description
                    : AppLocalizations.of(context).translate('screen.proceed'),
                // primaryColor: widget.giViewModel.getPrimaryColor(),
                answers: widget.item.answers,
                selected: _selected,
                buttonClick: (answerId, int? index) {
                  setState(() {
                    _selected[answerId] = !(_selected[answerId]??false);
                  });
                },
                buttonVisible: this.answerGiven(),
                submitClick: () {
                  this.submitPressed();
                },
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
      setState(() {
        if (widget.item.showFeedback)  _showCorrectFeedback = true;
      });
    } else {
      widget.submitWrongAnswer();
      setState(() {
        if (widget.item.showFeedback)  _showFalseFeedback = true;
      });
    }
    if (!widget.item.showFeedback) {
      widget.proceedToNextItem();
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
