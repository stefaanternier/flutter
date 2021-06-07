import 'package:flutter/material.dart';
import 'package:youplay/actions/run_actions.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/localizations.dart';
import 'package:youplay/models/general_item/single_choice.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/screens/general_item/general_item.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/current_run.picture.actions.dart';

import 'components/content_card_choices.dart';
import 'components/singlechoice/feedback_screen.dart';
import 'generic_message.dart';

class SingleChoiceWidget extends StatefulWidget {
  SingleChoiceGeneralItem item;
  GeneralItemViewModel giViewModel;

  SingleChoiceWidget({this.item, this.giViewModel, Key key})
      : super(key: key);


  @override
  _SingleChoiceWidgetState createState() => new _SingleChoiceWidgetState();
}

class _SingleChoiceWidgetState extends State<SingleChoiceWidget> {
  int _index = -1;
  bool _showFalseFeedback = false;
  bool _showCorrectFeedback = false;
  bool newLibrary = true;
  String wrongFeedback;
  String correctFeedback;

  @override
  initState() {
    super.initState();
    // Add listeners to this class
    widget.item.answers.forEach((choice) {
      _selected[choice.id] = false;
    });
  }

  Map<String, bool> _selected = new Map();
  @override
  Widget build(BuildContext context) {
    if (_showCorrectFeedback && widget.item.showFeedback) {
      return FeedbackScreen(
          result: 'correct',
          buttonText: AppLocalizations.of(context).translate('screen.next'),
          item: widget.item,
          feedback: "${widget.item.answers[_index].feedback}",
          overridePrimaryColor: widget.giViewModel.getPrimaryColor(),
          buttonClick: () {
            widget.giViewModel.continueToNextItem(context);
          },
        giViewModel: widget.giViewModel,
      );
    } else if (_showFalseFeedback && widget.item.showFeedback) {
      return FeedbackScreen(
          result: 'wrong',
          buttonText: 'Ok',
          item: widget.item,
          feedback: "${widget.item.answers[_index].feedback}",
          overridePrimaryColor: widget.giViewModel.getPrimaryColor(),
          buttonClick: () {
            setState(() {
              _showFalseFeedback = false;
            });
          });
    }
    return _buildQuestion(context);

  }

    Widget _buildQuestion(BuildContext context) {
      return  GeneralItemWidget(
          item: this.widget.item,
          giViewModel: this.widget.giViewModel,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Opacity(
                  opacity: 0.9,
                  child: Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: ContentCardChoices(
                          giViewModel: widget.giViewModel,
                          answers: widget.item.answers,
                          selected: _selected,
                          changeSelection: (bool value, int i, String id) {
                            setState(() {
                              widget.item.answers.forEach((choice) {
                                _selected[choice.id] = false;
                              });
                              _selected[widget.item.answers[i].id] = value;
                              _index = i;
                            },
                            );
                          },
                          buttonVisible: this.answerGiven(),
                          overridePrimaryColor: widget.giViewModel.getPrimaryColor(),
                          submitPressed: submitPressed)
                  ))
            ],
          )
      );
    }

  submitPressed() {
    widget.item.answers.forEach((choice) {

      if (_selected[choice.id]) {
        AppConfig().analytics.logEvent(
          name: "single_choice_submit",
          parameters: {
            'run': widget.giViewModel.run.runId,
            'itemId' : widget.item.itemId,
            'gameId' : widget.item.gameId,
            'itemTitle' : widget.item.title,
            'choiceId' : choice.id,
            'choiceTitle' : choice.answer,
            'correct' : choice.isCorrect
          }
        );
        widget.giViewModel.onDispatch(MultiplechoiceAction(
            mcResponse:
            Response(run: widget.giViewModel.run, item:widget.item, value: choice.id)));
      }

    });
    widget.giViewModel.onDispatch(SyncFileResponse(runId: widget.giViewModel.run.runId));

    widget.giViewModel.onDispatch(MultipleChoiceAnswerAction(
        generalItemId: widget.giViewModel.item.itemId,
        runId: widget.giViewModel.run.runId,
        answerId: widget.item.answers[_index].id));
    if (widget.item.answers[_index].isCorrect) {
      widget.giViewModel.onDispatch(AnswerCorrect(
        generalItemId: widget.giViewModel.item.itemId,
        runId: widget.giViewModel.run.runId,
      ));
      setState(() {
        _showCorrectFeedback = true;
      });
    } else {
      widget.giViewModel.onDispatch(AnswerWrong(
        generalItemId: widget.giViewModel.item.itemId,
        runId: widget.giViewModel.run.runId,
      ));
      setState(() {
        _showFalseFeedback = true;
      });
    }
    if (!widget.item.showFeedback) {
      bool result = widget.giViewModel.continueToNextItem(context);
      if (!result) {
        new Future.delayed(const Duration(milliseconds: 200), () {
          widget.giViewModel.continueToNextItem(context);
        });
      }
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


