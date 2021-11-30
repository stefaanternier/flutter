

import 'package:flutter/material.dart';
import 'package:youplay/models/general_item/text_question.dart';
import 'package:youplay/ui/components/buttons/cust_flat_button.dart';
import 'package:youplay/ui/components/appbar/themed-appbar.container.dart';
import 'package:youplay/ui/components/messages/message-background.widget.container.dart';
import 'package:youplay/ui/components/messages_parts/richtext-top.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';

class TextQuestionAnswer extends StatelessWidget {
  final TextQuestion item;
  final Function(String) submitText;
  final TextEditingController myController = TextEditingController();

  TextQuestionAnswer({
    required this.item,
    required this.submitText,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: ThemedAppbarContainer(title: item.title, elevation: false),
        body: WebWrapper(
            child: MessageBackgroundWidgetContainer(
              darken: true,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        RichTextTopContainer(),
                        Container(
                          // flex: 1,
                            child: Container(
                                color: Colors.black,
                                child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: new Scrollbar(
                                    child: new SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      reverse: true,
                                      child: TextField(
                                        autofocus: true,
                                        textInputAction: TextInputAction.send,
                                        controller: myController,
                                        onSubmitted: submitText,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ))),

                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(46, 8.0, 46, 28),
                      child: CustomFlatButton(
                        title: "Verstuur", //todo vertaal
                        icon: Icons.send,
                        color: Colors.white,
                        onPressed: () {
                          submitText(myController.value.text);
                        },
                      ),
                    ),
                  ]),
            )));
  }
}
