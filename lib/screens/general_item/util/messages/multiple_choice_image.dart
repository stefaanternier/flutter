import 'package:flutter/material.dart';
import 'package:youplay/actions/run_actions.dart';
import 'package:youplay/localizations.dart';
import 'package:youplay/models/general_item/multiple_choice_image.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/screens/general_item/general_item.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/current_run.picture.actions.dart';

import 'components/image_question.dart';
import 'components/singlechoice/feedback_screen.dart';
import 'generic_message.dart';

class MultipleChoiceWithImage extends StatefulWidget {
  MultipleChoiceImageGeneralItem item;
  GeneralItemViewModel giViewModel;

  MultipleChoiceWithImage({required this.item, required this.giViewModel, Key? key})
      : super(key: key);

  @override
  _MultipleChoiceWithImageState createState() => new _MultipleChoiceWithImageState();
}

class _MultipleChoiceWithImageState extends State<MultipleChoiceWithImage> {
  late Map<String, bool> _selected = new Map();
  bool _showFalseFeedback = false;
  bool _showCorrectFeedback = false;
  bool _showFeedback = true;
  String? wrongFeedback;

  String? correctFeedback;

  @override
  initState() {
    super.initState();
    _showFeedback = widget.item.showFeedback;
    widget.item.answers.forEach((choice) {
      _selected[choice.id] = false;

      if (choice.isCorrect) {
        correctFeedback = choice.feedback;
      } else {
        wrongFeedback = choice.feedback;
      }
    });
  }

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: new AppBar(
//            backgroundColor: widget.giViewModel.getPrimaryColor(),
//            centerTitle: true,
//            title: new Text(widget.item.title)),
//        body: buildBody(context));
//  }

  @override
  Widget build(BuildContext context) {
    if (_showCorrectFeedback) {
      return FeedbackScreen(
          result: 'correct',
          buttonText: AppLocalizations.of(context).translate('screen.next'),
          item: widget.item,
          feedback: "$correctFeedback",
          overridePrimaryColor: widget.giViewModel.getPrimaryColor(),
          buttonClick: () {
            setState(() {
              _showFalseFeedback = false;
              _showCorrectFeedback = false;
            });
            widget.giViewModel.continueToNextItem(context);

          },
          giViewModel: this.widget.giViewModel,

          );
    } else if (_showFalseFeedback) {
      return FeedbackScreen(
          result: 'wrong',
          buttonText: 'Ok',
          item: widget.item,
          feedback: "$wrongFeedback",
          overridePrimaryColor: widget.giViewModel.getPrimaryColor(),
          buttonClick: () {
            setState(() {
              _showFalseFeedback = false;
            });
          });
    }
    return GeneralItemWidget(
        item: this.widget.item,
        giViewModel: this.widget.giViewModel,
        body: ImageQuestion(
          item: widget.item,
          primaryColor: widget.giViewModel.getPrimaryColor(),
          answers: widget.item.answers,
          selected: _selected,
          buttonClick: (answerId) {
            setState(() {
              _selected[answerId] = !(_selected[answerId]??false);
            });
          },
          buttonVisible: this.answerGiven(),
          submitClick: submitPressed,
          giViewModel: this.widget.giViewModel,
        ));
  }

  submitPressed() {
    bool correct = true;
    _selected.forEach((answerid, value) {
      if (value) {
        if (widget.giViewModel.item != null && widget.giViewModel.run?.runId != null) {
          widget.giViewModel.onDispatch(MultipleChoiceAnswerAction(
              generalItemId: widget.giViewModel.item!.itemId,
              runId: widget.giViewModel.run!.runId!,
              answerId: answerid));
          widget.giViewModel.onDispatch(MultiplechoiceAction(
              mcResponse:
              Response(run: widget.giViewModel.run,
                  item: widget.item,
                  value: answerid)));
        }
      }
    });
    if (widget.giViewModel.item != null && widget.giViewModel.run?.runId != null) {
      widget.giViewModel.onDispatch(
          SyncFileResponse(runId: widget.giViewModel.run!.runId!));
    }

    widget.item.answers.forEach((choiceAnswer) {
      if (choiceAnswer.isCorrect != _selected[choiceAnswer.id]) {
        correct = false;
      }
    });
    if (correct) {
      if (widget.giViewModel.item != null && widget.giViewModel.run?.runId != null) {
        widget.giViewModel.onDispatch(AnswerCorrect(
          generalItemId: widget.giViewModel.item!.itemId,
          runId: widget.giViewModel.run!.runId!,
        ));
      }
      setState(() {
        if (widget.item.showFeedback) _showCorrectFeedback = true;
      });
    } else {
      if (widget.giViewModel.item != null && widget.giViewModel.run?.runId != null) {
        widget.giViewModel.onDispatch(AnswerWrong(
          generalItemId: widget.giViewModel.item!.itemId,
          runId: widget.giViewModel.run!.runId!,
        ));
      }
      setState(() {
        if (widget.item.showFeedback) _showFalseFeedback = true;
      });
    }
    if (!widget.item.showFeedback) {
      new Future.delayed(const Duration(milliseconds: 100)).then((value) {
        if (!widget.giViewModel.continueToNextItem(context)) {
          Navigator.pop(context);
        }
      });
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
