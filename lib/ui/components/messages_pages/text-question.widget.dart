import 'package:flutter/material.dart';
import 'package:youplay/models/general_item/text_question.dart';
import 'package:youplay/ui/components/messages/text_question/text-question-answer.dart';
import 'package:youplay/ui/components/messages/text_question/text-question.list.widget.dart';

enum QuestionStatus { list, answer }

class TextQuestionWidget extends StatefulWidget {
  final TextQuestion item;
  final Function(String) submitText;

  const TextQuestionWidget({
    required this.item,
    required this.submitText,
    Key? key}) : super(key: key);

  @override
  _TextQuestionWidgetState createState() => _TextQuestionWidgetState();
}

class _TextQuestionWidgetState extends State<TextQuestionWidget> {
  QuestionStatus status = QuestionStatus.list;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case QuestionStatus.list:
        {
          return TextQuestionList(
            tapProvideAnswer: () {
              setState(() {
                status = QuestionStatus.answer;
              });
            },
            item: widget.item,
          );
        }
      case QuestionStatus.answer:
        {
          return TextQuestionAnswer(
            submitText: (String val){
              widget.submitText(val);
              setState(() {
                status = QuestionStatus.list;
              });
            },
            item: widget.item,
          );
        }
    }
  }
}
