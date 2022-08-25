import 'dart:math';

import 'package:flutter/material.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/general_item/multiple_choice_image.dart';
import 'package:youplay/ui/components/buttons/cust_raised_button.container.dart';

import 'image-question-entry.container.dart';

class ImageQuestion extends StatelessWidget {
  final String? buttonText;
  final GeneralItem item;
  final Color? primaryColor;
  final Function(String, int?) buttonClick;
  final Function() submitClick;
  final bool buttonVisible;
  final List<ImageChoiceAnswer> answers;
  final Map<String, bool> selected;

  const ImageQuestion(
      {required this.item,
      this.primaryColor,
      this.buttonText,
      required this.answers,
      required this.selected,
      required this.buttonVisible,
      required this.buttonClick,
      required this.submitClick,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Opacity(
                opacity: 0.9,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                  child: buildBottomCard(context),
                ))
          ],
        ));
  }

  Widget buildBottomCard(BuildContext context) {
    return Card(
      child: LimitedBox(
        maxHeight: MediaQuery.of(context).size.height * 0.66,
        child: Scrollbar(
          isAlwaysShown: true,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Visibility(
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "${(item as dynamic).text}",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                      )),
                  visible: (item as dynamic).text != '' && (item as dynamic).text != null,
                ),
                Container(
                    padding: const EdgeInsets.all(10),
                    child: buildGrid(
                        (index, length) => ImageQuestionEntryContainer(
                          scale: getScale(index, length),
                          buttonClick: buttonClick,
                          index: index,
                          isSelected: selected[answers[index].id] ?? false,
                          imagePath: item.fileReferences?[answers[index].id],
                          answerId: answers[index].id,
                        )

                    )),
                Visibility(
                  visible: buttonVisible,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 12),
                      child: CustomRaisedButtonContainer(
                        title: buttonText ?? 'todo',
                        onPressed: () {
                          submitClick();
                        },
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildGrid(Function widgetBuilder) {
    int scale = 2;
    if (answers.length < 3) {
      scale = 1;
    }
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List<Widget>.generate(
            (answers.length / scale).ceil(),
            (colIndex) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List<Widget>.generate(min(scale, (answers.length - colIndex * scale)),
                    (rowIndex) => widgetBuilder(colIndex * scale + rowIndex, answers.length)))));
  }

  double getScale(int index, int length) {
    if (length < 3) {
      return 2;
    }
    if (length % 2 == 1 && index == (length - 1)) {
      return 2;
    }
    return 1;
  }

}
