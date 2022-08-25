import 'package:flutter/material.dart';
import 'package:youplay/localizations.dart';
import 'package:youplay/models/general_item/single_choice_image.dart';
import 'package:youplay/ui/components/appbar/themed-appbar.container.dart';
import 'package:youplay/ui/components/messages/feedback-screen/feedback_screen.dart';
import 'package:youplay/ui/components/messages/image-question/image_question.dart';
import 'package:youplay/ui/components/messages/message-background.widget.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

class SingleChoiceImageWidget extends StatefulWidget {
  final SingleChoiceImageGeneralItem item;
  Function(String) submit;
  Function() submitCorrectAnswer;
  Function() submitWrongAnswer;
  Function() proceedToNextItem;

  SingleChoiceImageWidget(
      {required this.item,
        required this.submit,
        required this.submitCorrectAnswer,
        required this.submitWrongAnswer,
        required this.proceedToNextItem,
        Key? key})
      : super(key: key);

  @override
  _SingleChoiceImageWidgetState createState() => _SingleChoiceImageWidgetState();
}

class _SingleChoiceImageWidgetState extends State<SingleChoiceImageWidget> {
  int _index = -1;
  bool _showFalseFeedback = false;
  bool _showCorrectFeedback = false;

  late Map<String, bool> _selected = new Map();

  @override
  initState() {
    super.initState();
    widget.item.answers.forEach((choice) {
      _selected[choice.id] = false;
    });
  }

  resetSelected() {
    widget.item.answers.forEach((choice) {
      _selected[choice.id] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showCorrectFeedback) {
      return FeedbackScreen(
        result: 'correct',
        buttonText: AppLocalizations.of(context).translate('screen.next'),
        item: widget.item,
        feedback: "${widget.item.answers[_index].feedback}",
        // overridePrimaryColor: widget.giViewModel.getPrimaryColor(),
        buttonClick: widget.proceedToNextItem,
      );
    } else if (_showFalseFeedback) {
      return FeedbackScreen(
          result: 'wrong',
          buttonText: 'Ok',
          item: widget.item,
          feedback: "${widget.item.answers[_index].feedback}",
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
              child: ImageQuestion(
                item: widget.item,
                buttonText: (widget.item.description != '')
                    ? widget.item.description
                    : AppLocalizations.of(context).translate('screen.proceed'),
                // primaryColor: widget.giViewModel.getPrimaryColor(),
                answers: widget.item.answers,
                selected: _selected,
                buttonClick: (answerId, int? index) {
print('answerId is ${answerId}');
                  setState(() {
                    resetSelected();
                    _selected[answerId] = !(_selected[answerId]??false);
                    _index = index ?? -1;
                  });
                },
                buttonVisible: this.answerGiven(),
                submitClick: () {
                  print('in sssss mit p1r');
                  this.submitPressed();
                },
                // giViewModel: this.widget.giViewModel,
              ),
            )));
  }

  submitPressed() {
    print('in sssss mit pr ${_index}');
    widget.item.answers.forEach((choice) {
      if (_selected[choice.id] ?? false) {
        widget.submit(choice.id);
      }
    });
    if (widget.item.answers[_index].isCorrect) {
      widget.submitCorrectAnswer();
      print('submit correct answer');
      setState(() {
        if (widget.item.showFeedback) _showCorrectFeedback = true;
      });
    } else {
      print('submit wrong answer');
      widget.submitWrongAnswer();
      setState(() {
        if (widget.item.showFeedback) _showFalseFeedback = true;
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
