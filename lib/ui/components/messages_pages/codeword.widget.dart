import 'package:flutter/material.dart';
import 'package:youplay/localizations.dart';
import 'package:youplay/models/general_item/code_word.dart';
import 'package:youplay/ui/components/appbar/themed-appbar.container.dart';
import 'package:youplay/ui/components/messages/codeword/code_word_entry.dart';
import 'package:youplay/ui/components/messages/feedback-screen/feedback_screen.dart';
import 'package:youplay/ui/components/messages/message-background.widget.container.dart';
import 'package:youplay/ui/components/messages_parts/richtext-top.container.dart';
import 'package:youplay/ui/components/next_button/next_button.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

import '../messages/combination_lock/combination-lock.button.container.dart';

class CodeWordWidget extends StatefulWidget {
  final CodeWordGeneralItem item;
  Function(String choiceId, bool isCorrect) processAnswerMatch;
  Function() processAnswerNoMatch;
  int lockLength;
  bool isNumeric;
  final Function() proceedToNextItem;

  String? answer;

  CodeWordWidget(
      {required this.item,
      required this.processAnswerMatch,
      required this.processAnswerNoMatch,
      required this.proceedToNextItem,
      required this.lockLength,
      required this.isNumeric,
        this.answer,
      Key? key})
      : super(key: key);

  @override
  _CodeWordWidgetState createState() => _CodeWordWidgetState();
}

class _CodeWordWidgetState extends State<CodeWordWidget> {
  int _index = -1;
  String _answer = "";

  bool _showFalseFeedback = false;
  bool _showCorrectFeedback = false;

  FocusNode focusNode = FocusNode();
  bool show = false;
  late TextField tf;
  TextEditingController _controller = new TextEditingController();

  @override
  initState() {
    super.initState();
    _controller.addListener(() {
print ("in controller add listeren");
      setState(() {
        _answer = _controller.text.toUpperCase();
        print ('answer is $_answer');
      });
    });


  }

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
    if (widget.answer != null) {
      return GestureDetector(

            onTap: (){
              print('foucs');
              // focusNode.requestFocus();
            },
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: ThemedAppbarContainer(title: widget.item.title, elevation: false),
            body: WebWrapper(
                child: MessageBackgroundWidgetContainer(

                  onTap: () {
                    print('backgournd tap');
                  },
                  darken: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        RichTextTopContainer(),
                        Flexible(
                          flex: 1,
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: (){
                              print('foucs');
                              focusNode.requestFocus();
                            },
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Expanded(
                                    child:  Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: List<CodeWordEntry>.generate(
                                            widget.lockLength,
                                                (i) => CodeWordEntry(
                                              index: i,
                                              text: i < widget.answer!.length ? widget.answer![i] : ' ',
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
                              )),),

                      ],

                  ),
                ))
          // ),
        ),
      );
    }


    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: ThemedAppbarContainer(title: widget.item.title, elevation: false),
        body: WebWrapper(
            child: MessageBackgroundWidgetContainer(
              onTap: () {
                if (!show) {
                  focusNode.requestFocus();
                  setState(() {
                    show = true;
                  });
                } else {

                  FocusScope.of(context).unfocus();

                  setState(() {
                    show = false;
                  });
                }

              },
          darken: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RichTextTopContainer(),
              Flexible(
                flex: 1,
                child: GestureDetector(
                    onTap: () {
                      focusNode.requestFocus();
                      setState(() {
                        show = true;
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        if (widget.lockLength >0) TextField(
                          maxLength: widget.lockLength,
                          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(255, 0, 0, 0)),
                          focusNode: focusNode,
                          controller: _controller,
                          showCursor: false,
                          enableInteractiveSelection: false,
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          onSubmitted: (test) {
                            print('submitted $test');
                            setState(() {
                              show=false;
                            });
                          },
                        ),
                        Expanded(
                          flex: show ? 0 : 1 ,
                          child: GestureDetector(
                            onTap: focusNode.requestFocus,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: List<CodeWordEntry>.generate(
                                  widget.lockLength,
                                  (i) => CodeWordEntry(
                                    index: i,
                                    text: i < _answer.length ? _answer[i] : ' ',
                                  ),
                                )),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(46, 8.0, 46, 8),
                            child: NextButtonContainer(item: widget.item)),
                        Visibility(
                          visible: !show,
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(46, 8.0, 46, 28),
                              child: CombinationLockButtonContainer(
                                unlock: unlock,
                              )),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ))
        // ),
        );
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
    print("in unlock ${_answer}");
    widget.item.answers.forEach((choice) {
      print("check choice ${choice.answer} - $_answer");
      if (_answer != "" && choice.answer.toUpperCase() == _answer) {
        matchFound = true;
        print("match found ${choice.isCorrect}");
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



      } else {
        //todo some kind of catch all?
        setState(() {
          _answer = "";
          _controller.text = "";
        });
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
