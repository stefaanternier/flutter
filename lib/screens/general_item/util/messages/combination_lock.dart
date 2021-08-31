import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youplay/actions/run_actions.dart';
import 'package:youplay/localizations.dart';
import 'package:youplay/models/general_item/combination_lock.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/screens/general_item/general_item.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/current_run.picture.actions.dart';
import 'package:youplay/store/state/app_state.dart';

import 'combination_lock.viewmodel.dart';
import 'components/combination_lock_entry.dart';
import 'components/game_themes.viewmodel.dart';
import 'components/next_button.dart';
import 'components/singlechoice/feedback_screen.dart';
import 'generic_message.dart';

class CombinationLockWidget extends StatefulWidget {
  CombinationLockGeneralItem item;
  GeneralItemViewModel giViewModel;

  CombinationLockWidget(
      {required this.item, required this.giViewModel, Key? key})
      : super(key: key);

  @override
  _CombinationLockWidgetState createState() =>
      new _CombinationLockWidgetState();
}

class _CombinationLockWidgetState extends State<CombinationLockWidget> {
  int _lockLength = 3;
  int _index = -1;
  String _answer = "-";
  bool _numeric = true;
  bool _showFalseFeedback = false;
  bool _showCorrectFeedback = false;
  bool newLibrary = true;
  String? wrongFeedback;
  String? correctFeedback;

  @override
  initState() {
    super.initState();
    // Add listeners to this class
    this.widget.item.answers.forEach((choice) {
      _selected[choice.id] = false;
      if (choice.isCorrect) {
        setState(() {
          _lockLength = choice.answer.length;
          _numeric = isNumeric(choice.answer);
          _answer = "";
          for (int i = 0; i < _lockLength; i++) {
            _answer += _numeric ? "0" : "a";
          }
        });
      }
    });
    if (this._answer == "-") {
      int longest = 0;
      this.widget.item.answers.forEach((choice) {
        if (choice.answer.length > longest) longest = choice.answer.length;
      });
      this._answer = "";
      for (int i = 0; i < longest; i++) {
        this._answer += "0";
      }
    }
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
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
          });
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
    if (this.widget.giViewModel.item == null) {
      return Container(
          child: Text('item loading...')); //todo make message beautiful
    }
    return GeneralItemWidget(
        item: this.widget.item,
        giViewModel: this.widget.giViewModel,
        padding: false,
        elevation: false,
        body: Container(
          color: Color.fromRGBO(0, 0, 0, 0.7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new StoreConnector<AppState, GameThemesViewModel>(
                  converter: (store) => GameThemesViewModel.fromStore(store),
                  builder: (context, GameThemesViewModel themeModel) {
                    return Container(
                        // color: this.widget.giViewModel.getPrimaryColor(),
                        color: this.widget.giViewModel.getPrimaryColor() != null
                            ? this.widget.giViewModel.getPrimaryColor()
                            : themeModel.getPrimaryColor(),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "${this.widget.item.text}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ));
                  }),
              Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: buildCombinationLock(),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(46, 8.0, 46, 8),
                          child: NextButton(
                              buttonText: this
                                          .widget
                                          .giViewModel
                                          .item!
                                          .description !=
                                      ""
                                  ? this.widget.giViewModel.item!.description
                                  : AppLocalizations.of(context)
                                      .translate('screen.proceed'),
                              overridePrimaryColor:
                                  widget.giViewModel.getPrimaryColor(),
                              giViewModel: widget.giViewModel)),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(46, 8.0, 46, 28),
                          child: buildLockButton()),
                    ],
                  )),
            ],
          ),
        ));
  }

  Widget buildLockButton() {
    return new StoreConnector<AppState, CombinationLockViewModel>(
        converter: (store) => CombinationLockViewModel.fromStore(store),
        builder: (context, CombinationLockViewModel lockModel) {
          return Visibility(
            visible: !lockModel.correctAnswerGiven,
            child: Column(children: [
              ClipOval(
                child: Material(
                  color: Colors.white, // button color
                  child: InkWell(
                    splashColor: widget.giViewModel.getPrimaryColor(),
                    child: SizedBox(
                        width: 94,
                        height: 94,
                        child: Icon(
                          FontAwesomeIcons.unlockAlt,
                          color: widget.giViewModel.getPrimaryColor(),
                        )),
                    onTap: () {
                      unlock();
                    },
                  ),
                ),
              ),
            ]),
          );
        });
  }

  buildCombinationLock() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List<CombinationLockEntry>.generate(
          _lockLength,
          (i) => CombinationLockEntry(
            isNumeric: _numeric,
            index: i,
            valueChanged: (val, index) {
              print('value changed');
              setState(() {
                if (_answer.length <= index) {
                  _answer = _answer + val[0];
                } else {
                  _answer = _answer.substring(0, index) +
                      val[0] +
                      _answer.substring(index + 1);
                }
              });
            },
          ),
        )
        // [
        //   CombinationLockEntry(),
        //   CombinationLockEntry(),
        //   // buildCombinationLockEntry()
        // ],
        );
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
        if (this.widget.giViewModel.item != null &&
            widget.giViewModel.run?.runId != null) {
          widget.giViewModel.onDispatch(MultiplechoiceAction(
              mcResponse: Response(
                  run: widget.giViewModel.run,
                  item: widget.item,
                  value: choice.id)));

          widget.giViewModel.onDispatch(MultipleChoiceAnswerAction(
              generalItemId: widget.giViewModel.item!.itemId,
              runId: widget.giViewModel.run!.runId!,
              answerId: choice.id));

          if (choice.isCorrect) {
            widget.giViewModel.onDispatch(AnswerCorrect(
              generalItemId: widget.giViewModel.item!.itemId,
              runId: widget.giViewModel.run!.runId!,
            ));
            setState(() {
              _showCorrectFeedback = true;
            });
          } else {
            widget.giViewModel.onDispatch(AnswerWrong(
              generalItemId: widget.giViewModel.item!.itemId,
              runId: widget.giViewModel.run!.runId!,
            ));
            setState(() {
              _showFalseFeedback = true;
            });
          }
        }

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
      if (this.widget.giViewModel.item != null &&
          widget.giViewModel.run?.runId != null) {
        widget.giViewModel.onDispatch(AnswerWrong(
          generalItemId: widget.giViewModel.item!.itemId,
          runId: widget.giViewModel.run!.runId!,
        ));
      }
      setState(() {
        _showFalseFeedback = true;
      });
    }
    counter++;
    if (widget.giViewModel.run?.runId != null) {
      widget.giViewModel
          .onDispatch(SyncFileResponse(runId: widget.giViewModel.run!.runId!));
    }
  }
}
