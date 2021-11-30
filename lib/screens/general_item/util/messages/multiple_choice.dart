// import 'package:flutter/material.dart';
// import 'package:youplay/actions/run_actions.dart';
// import 'package:youplay/localizations.dart';
// import 'package:youplay/models/general_item/single_choice.dart';
// import 'package:youplay/models/response.dart';
// import 'package:youplay/screens/general_item/general_item.dart';
// import 'package:youplay/store/actions/current_run.actions.dart';
// import 'package:youplay/store/actions/current_run.picture.actions.dart';
//
// import 'components/content_card_choices.dart';
// import 'components/singlechoice/feedback_screen.dart';
// import 'generic_message.dart';
//
// class MultipleChoiceWidget extends StatefulWidget {
//   MultipleChoiceGeneralItem item;
//   GeneralItemViewModel giViewModel;
//
//   MultipleChoiceWidget({required this.item, required this.giViewModel, Key? key})
//       : super(key: key);
//
//
//   @override
//   _MultipleChoiceWidgetState createState() => new _MultipleChoiceWidgetState();
// }
//
// class _MultipleChoiceWidgetState extends State<MultipleChoiceWidget> {
//
//   Map<String, bool> _selected = new Map();
//   bool _showFalseFeedback = false;
//   bool _showCorrectFeedback = false;
//   String? wrongFeedback;
//   String? correctFeedback;
//
//   @override
//   initState() {
//     super.initState();
//     // Add listeners to this class
//     widget.item.answers.forEach((choice) {
//       _selected[choice.id] = false;
//       if (choice.isCorrect) {
//         correctFeedback = choice.feedback;
//       } else {
//         wrongFeedback = choice.feedback;
//       }
//     });
//   }
//
//   build(BuildContext context) {
//     if (_showCorrectFeedback) {
//       return FeedbackScreen(
//           result: 'correct',
//           buttonText: AppLocalizations.of(context).translate('screen.next'),
//           item: widget.item,
//           feedback: "$correctFeedback",
//           overridePrimaryColor: widget.giViewModel.getPrimaryColor(),
//           buttonClick: () {
//             widget.giViewModel.continueToNextItem(context);
//           },
//         giViewModel: widget.giViewModel,);
//     } else if (_showFalseFeedback) {
//       return FeedbackScreen(
//           result: 'wrong',
//           buttonText: 'Ok',
//           item: widget.item,
//           feedback: "$wrongFeedback",
//           overridePrimaryColor: widget.giViewModel.getPrimaryColor(),
//           buttonClick: () {
//             setState(() {
//               _showFalseFeedback = false;
//             });
//           });
//     }
//     return _buildQuestion(context);
//   }
//
//
//   Widget _buildQuestion(BuildContext context) {
//    return  GeneralItemWidget(
//         item: this.widget.item,
//         giViewModel: this.widget.giViewModel,
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: <Widget>[
//             Opacity(
//                 opacity: 0.9,
//                 child: Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
//                     child: ContentCardChoices(
//                         giViewModel: widget.giViewModel,
//                         answers: widget.item.answers,
//                         selected: _selected,
//                         changeSelection: (bool value, int i, String id) {
//                           setState(() {
//                             _selected[widget.item.answers[i].id] = value;
//                           });
//                         },
//                         buttonVisible: this.answerGiven(),
//                         submitPressed: submitPressed
//                     )))
//           ],
//         )
//     );
//   }
//
//   submitPressed() {
//     bool correct = true;
//     _selected.forEach((answerid, value) {
//       if (value && widget.giViewModel.item != null && widget.giViewModel.run?.runId != null) {
//         widget.giViewModel.onDispatch(MultipleChoiceAnswerAction(
//             generalItemId: widget.giViewModel.item!.itemId,
//             runId: widget.giViewModel.run!.runId!,
//             answerId: answerid));
//         widget.giViewModel.onDispatch(MultiplechoiceAction(
//             mcResponse:
//             Response(run: widget.giViewModel.run, item:widget.item, value: answerid)));
//       }
//     });
//     if (widget.giViewModel.item != null && widget.giViewModel.run?.runId != null) {
//       widget.giViewModel.onDispatch(
//           SyncFileResponse(runId: widget.giViewModel.run!.runId!));
//     }
//     widget.item.answers.forEach((choiceAnswer) {
//       if (choiceAnswer.isCorrect != _selected[choiceAnswer.id]) {
//         correct = false;
//       }
//     });
//     if (correct) {
//       if (widget.giViewModel.item != null && widget.giViewModel.run?.runId != null) {
//         widget.giViewModel.onDispatch(AnswerCorrect(
//           generalItemId: widget.giViewModel.item!.itemId,
//           runId: widget.giViewModel.run!.runId!,
//         ));
//       }
//       setState(() {
//         if (widget.item.showFeedback)  _showCorrectFeedback = true;
//       });
//     } else {
//       if (widget.giViewModel.item != null && widget.giViewModel.run?.runId != null) {
//         widget.giViewModel.onDispatch(AnswerWrong(
//           generalItemId: widget.giViewModel.item!.itemId,
//           runId: widget.giViewModel.run!.runId!,
//         ));
//       }
//       setState(() {
//         if (widget.item.showFeedback)  _showFalseFeedback = true;
//       });
//     }
//     if (!widget.item.showFeedback) {
//       new Future.delayed(const Duration(milliseconds: 100)).then((value) {
//         if (!widget.giViewModel.continueToNextItem(context)) {
//           Navigator.pop(context); //todo do not pop
//         }
//       });
//     }
//   }
//
//   bool answerGiven() {
//     var returnValue = false;
//     _selected.forEach((id, b) {
//       if (b) {
//         returnValue = true;
//       }
//     });
//     return returnValue;
//   }
// }
