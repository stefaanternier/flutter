import 'package:flutter/material.dart';
import 'package:youplay/actions/run_actions.dart';
import 'package:youplay/models/general_item/single_choice_image.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/screens/general_item/general_item.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/current_run.picture.actions.dart';

import 'components/image_question.dart';
import 'components/singlechoice/feedback_screen.dart';
import 'generic_message.dart';

class SingleChoiceWithImage extends StatefulWidget {
  SingleChoiceImageGeneralItem item;
  GeneralItemViewModel giViewModel;

  SingleChoiceWithImage(
      {required this.item, required this.giViewModel, Key? key})
      : super(key: key);

  @override
  _SingleChoiceWithImageState createState() =>
      new _SingleChoiceWithImageState();
}

class _SingleChoiceWithImageState extends State<SingleChoiceWithImage> {
  late Map<String, bool> _selected = new Map();
  bool _showFalseFeedback = false;
  bool _showCorrectFeedback = false;

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
    String feedback = '';
    _selected.keys.forEach((answerId) {
      if (_selected[answerId]??false) {
        widget.item.answers.forEach((choice) {
          if (choice.id == answerId) {
            feedback = choice.feedback;
          }
        });
      }
    });

    if (_showCorrectFeedback && widget.item.showFeedback) {
      return FeedbackScreen(
        result: 'correct',
        buttonText: 'Verder',
        item: widget.item,
        feedback: "${feedback}",
        overridePrimaryColor: widget.giViewModel.getPrimaryColor(),
        buttonClick: () {
          setState(() {
            _showCorrectFeedback = false;
          });
          widget.giViewModel.continueToNextItem(context);
        },
        giViewModel: this.widget.giViewModel,
      );
    } else if (_showFalseFeedback && widget.item.showFeedback) {
      return FeedbackScreen(
        result: 'wrong',
        buttonText: 'Ok',
        item: widget.item,
        feedback: "${feedback}",
        overridePrimaryColor: widget.giViewModel.getPrimaryColor(),
        buttonClick: () {
          setState(() {
            _showFalseFeedback = false;
          });
        },
      );
    }
    return GeneralItemWidget(
        item: this.widget.item,
        giViewModel: this.widget.giViewModel,
        body: ImageQuestion(
          item: widget.item,
          primaryColor: widget.giViewModel.getPrimaryColor(),
          answers: widget.item.answers,
          selected: _selected,
          buttonClick: (answerId, int? i) {
            setState(() {
              resetSelected();
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
        if (widget.giViewModel.item != null &&
            widget.giViewModel.run?.runId != null) {
          widget.giViewModel.onDispatch(MultipleChoiceAnswerAction(
              generalItemId: widget.giViewModel.item!.itemId,
              runId: widget.giViewModel.run!.runId!,
              answerId: answerid));
          widget.giViewModel.onDispatch(MultiplechoiceAction(
              mcResponse: Response(
                  run: widget.giViewModel.run,
                  item: widget.item,
                  value: answerid)));
        }
      }
    });
    if (widget.giViewModel.item != null &&
        widget.giViewModel.run?.runId != null) {
      widget.giViewModel
          .onDispatch(SyncFileResponse(runId: widget.giViewModel.run!.runId!));

      widget.item.answers.forEach((choiceAnswer) {
        if (choiceAnswer.isCorrect != _selected[choiceAnswer.id]) {
          correct = false;
        }
      });
      if (correct) {
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
    if (!widget.item.showFeedback) {
      setState(() {
        bool result = widget.giViewModel.continueToNextItem(context);
        if (!result) {
          new Future.delayed(const Duration(milliseconds: 500), () {
            widget.giViewModel.continueToNextItem(context);
          });
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
//
//class SingleChoiceButtons extends StatefulWidget {
//  List<ImageChoiceAnswer> answers;
//  SingleChoiceImageGeneralItem item;
//  GeneralItemViewModel giViewModel;
//
//  SingleChoiceButtons({this.answers, this.item, this.giViewModel});
//
//  @override
//  SingleChoiceButtonsState createState() => SingleChoiceButtonsState();
//}
//
//class SingleChoiceButtonsState extends State<SingleChoiceButtons> {
//  bool newLibrary = true;
//  int _index = -1;
//  bool _showFalseFeedback = false;
//  bool _showCorrectFeedback = false;
//
////  List<ChoiceAnswer> answers ;
//
//  SingleChoiceButtonsState();
//
//  Color getPrimaryColor() {
//    return widget.item.primaryColor == null
//        ? widget.giViewModel.game.config.primaryColor
//        : widget.item.primaryColor;
//  }
//
//  @override
//  Widget buildFalseFeedback(BuildContext context) {
//    return Card(
//      child: Column(
//        mainAxisSize: MainAxisSize.min,
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          Container(
//              padding: const EdgeInsets.all(10),
//              child: Text(
//                "${widget.answers[_index].feedback}",
//                style: TextStyle(
//                  fontSize: 24,
//                  fontWeight: FontWeight.bold,
//                ),
//              )),
//          ButtonTheme.bar(
//            // make buttons use the appropriate styles for cards
//            child: ButtonBar(
//              children: <Widget>[
//                FlatButton(
//                  child: const Text('OK'),
//                  onPressed: () {
//                    setState(() {
//                      _showFalseFeedback = false;
//                    });
//                  },
//                ),
//              ],
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//
//  @override
//  Widget buildCorrectFeedback(BuildContext context) {
//    return Card(
//      child: Column(
//        mainAxisSize: MainAxisSize.min,
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          Container(
//              padding: const EdgeInsets.all(10),
//              child: Text(
//                "${widget.answers[_index].feedback}",
//                style: TextStyle(
//                  fontSize: 24,
//                  fontWeight: FontWeight.bold,
//                ),
//              )),
//          ButtonTheme.bar(
//            // make buttons use the appropriate styles for cards
//            child: ButtonBar(
//              children: <Widget>[
//                FlatButton(
//                  child: const Text('VERDER'),
//                  onPressed: () {
//                    widget.giViewModel.continueToNextItem();
//                  },
//                ),
//              ],
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//
//  Widget buildClickArea(int index) {
//    return new Expanded(
//        child: Padding(
//            padding: EdgeInsets.all(4),
//            child: GestureDetector(
//                onTap: () {
//                  setState(() {
//                    _index = index;
//                  });
//                },
//                child: Container(
//                    height: 150.0,
//                    alignment: Alignment(0.95, -0.95),
//                    child: _index == index ? Icon(Icons.check_circle) : null,
//                    decoration: new BoxDecoration(
//                      color: _index == index
//                          ? Color.fromRGBO(1, 1, 1, 0.5)
//                          : Color.fromRGBO(1, 1, 1, 0.1),
//                      image: new DecorationImage(
//                        image:
//                            buildSelectImage(context, widget.answers[index].id),
//                        fit: BoxFit.contain,
//                      ),
//                    )))));
//  }
//
//  CachedNetworkImageProvider buildSelectImage(
//      BuildContext context, String answerId) {
//    if (this.newLibrary &&
//        widget.item.fileReferences != null &&
//        widget.item.fileReferences[answerId] != null)
//      return new CachedNetworkImageProvider(
//          "https://storage.googleapis.com/${AppConfig().projectID}.appspot.com${widget.item.fileReferences[answerId].replaceFirst('//', '/')}",
//          errorListener: () {
//        setState(() {
//          this.newLibrary = false;
//        });
//      });
//    return new CachedNetworkImageProvider(
//      "https://storage.googleapis.com/${AppConfig().projectID}.appspot.com/game/${widget.item.gameId}/generalItems/${widget.item.itemId}/${answerId}.png",
//    );
//  }
//
//  CachedNetworkImageProvider buildImage(BuildContext context) {
//    if (_showCorrectFeedback) {
//      print("in build image correct feedback ");
//      if (this.newLibrary &&
//          widget.item.fileReferences != null &&
//          widget.item.fileReferences['correct'] != null)
//        return new CachedNetworkImageProvider(
//            "https://storage.googleapis.com/${AppConfig().projectID}.appspot.com${widget.item.fileReferences['correct'].replaceFirst('//', '/')}",
//            errorListener: () {
//          setState(() {
//            this.newLibrary = false;
//          });
//        });
//      return new CachedNetworkImageProvider(
//        "https://storage.googleapis.com/${AppConfig().projectID}.appspot.com/game/${widget.item.gameId}/generalItems/${widget.item.itemId}/correct.jpg",
//      );
//
////      return new NetworkImage(
////          "https://storage.googleapis.com/${AppConfig().projectID}.appspot.com/game/${widget.item.gameId}/generalItems/${widget.item.itemId}/correct.jpg"
////      );
//
//    }
//    if (_showFalseFeedback) {
//      if (this.newLibrary &&
//          widget.item.fileReferences != null &&
//          widget.item.fileReferences['wrong'] != null)
//        return new CachedNetworkImageProvider(
//            "https://storage.googleapis.com/${AppConfig().projectID}.appspot.com${widget.item.fileReferences['wrong'].replaceFirst('//', '/')}",
//            errorListener: () {
//          setState(() {
//            this.newLibrary = false;
//          });
//        });
//      return new CachedNetworkImageProvider(
//        "https://storage.googleapis.com/${AppConfig().projectID}.appspot.com/game/${widget.item.gameId}/generalItems/${widget.item.itemId}/wrong.jpg",
//      );
//
////      return new NetworkImage(
////          "https://storage.googleapis.com/${AppConfig().projectID}.appspot.com/game/${widget.item.gameId}/generalItems/${widget.item.itemId}/wrong.jpg"
////      );
//    }
//
//    if (this.newLibrary &&
//        widget.item.fileReferences != null &&
//        widget.item.fileReferences['background'] != null)
//      return new CachedNetworkImageProvider(
//          "https://storage.googleapis.com/${AppConfig().projectID}.appspot.com${widget.item.fileReferences['background'].replaceFirst('//', '/')}",
//          errorListener: () {
//        setState(() {
//          this.newLibrary = false;
//        });
//      });
//    return new CachedNetworkImageProvider(
//      "https://storage.googleapis.com/${AppConfig().projectID}.appspot.com/game/${widget.item.gameId}/generalItems/${widget.item.itemId}/background.jpg",
//    );
////    return new NetworkImage(
////        "https://storage.googleapis.com/${AppConfig().projectID}.appspot.com/game/${widget.item.gameId}/generalItems/${widget.item.itemId}/background.jpg"
////    );
//  }
//
//  @override
//  Widget buildChoice(BuildContext context, Widget w) {
//    return Container(
//        decoration: new BoxDecoration(
//            image: new DecorationImage(
//                fit: BoxFit.cover, image: buildImage(context))),
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.end,
//          children: <Widget>[
//            Opacity(
//                opacity: 0.9,
//                child: Padding(
//                    padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
//                    child:
//                        w //SingleChoiceButtons(answers: widget.item.answers, item: widget.item, giViewModel: widget.giViewModel,),
//                    ))
//          ],
//        ));
//  }
//
//  @override
//  Widget buildButtons(BuildContext context) {
//    return Card(
//      child: Column(
//        mainAxisSize: MainAxisSize.min,
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          Container(
//              padding: const EdgeInsets.all(10),
//              child: Text(
//                widget.item.title,
//                style: TextStyle(
//                  fontSize: 24,
//                  fontWeight: FontWeight.bold,
//                ),
//              )),
//          Container(
//              padding: const EdgeInsets.all(10),
//              child: buildGrid((index) => buildClickArea(index))),
//          ButtonTheme.bar(
//            // make buttons use the appropriate styles for cards
//            child: ButtonBar(
//              children: <Widget>[
//                Visibility(
//                  child: RaisedButton(
//                    color: getPrimaryColor(),
//                    child: Text(
//                      'VERSTUUR',
//                      style: TextStyle(color: Colors.white.withOpacity(0.8)),
//                    ),
//                    onPressed: () {
//                      widget.giViewModel.onDispatch(MultipleChoiceAnswerAction(
//                          generalItemId: widget.giViewModel.item.itemId,
//                          runId: widget.giViewModel.runState.run.runId,
//                          answerId: widget.answers[_index].id));
//                      if (widget.answers[_index].isCorrect) {
//                        widget.giViewModel.onDispatch(AnswerCorrect(
//                          generalItemId: widget.giViewModel.item.itemId,
//                          runId: widget.giViewModel.runState.run.runId,
//                        ));
//                        //Navigator.pop(context);
//
//                        setState(() {
//                          _showCorrectFeedback = true;
//                        });
//                      } else {
//                        widget.giViewModel.onDispatch(AnswerWrong(
//                          generalItemId: widget.giViewModel.item.itemId,
//                          runId: widget.giViewModel.runState.run.runId,
//                        ));
//                        setState(() {
//                          _showFalseFeedback = true;
//                        });
//                      }
//                    },
//                  ),
//                  maintainSize: true,
//                  maintainAnimation: true,
//                  maintainState: true,
//                  visible: _index != -1,
//                ),
//              ],
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return buildChoice(
//        context,
//        _showCorrectFeedback
//            ? buildCorrectFeedback(context)
//            : _showFalseFeedback
//                ? buildFalseFeedback(context)
//                : buildButtons(context));
//  }
//
//  buildGrid(Function widgetBuilder) {
//    int scale = 2;
//
//    return Column(
//        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//        children: List<Widget>.generate(
//            (widget.answers.length / 2).ceil(),
//            (colIndex) => Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                children: List<Widget>.generate(
//                    min(scale, (widget.answers.length - colIndex * scale)),
//                    (rowIndex) => widgetBuilder(colIndex * scale + rowIndex))
//
////                <Widget>[widgetBuilder(colIndex*scale+0),,],
//                )));
//  }
//}
