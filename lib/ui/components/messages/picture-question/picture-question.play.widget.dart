import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youplay/models/general_item/narrator_item.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/ui/components/appbar/themed-appbar.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';
import 'package:youplay/util/extended_network_image.dart';

import '../message-background.widget.container.dart';

class PictureQuestionPlayWidget extends StatelessWidget {
  final PictureQuestion item;
  final Response response;
  final Function() back;
  final Function() onDelete;

  const PictureQuestionPlayWidget({
    required this.back,
    required this.item,
    required this.response,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final DateFormat formatter = DateFormat('HH:mm, d MMMM y');
    //final DateFormat formatter =  DateFormat.yMMMMd(Localizations.localeOf(context).languageCode).add_jm();
    final DateTime thatTime = DateTime.fromMillisecondsSinceEpoch(response.timestamp);
    return WillPopScope(
      onWillPop: () async {
        back();
        return false;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: ThemedAppbarContainer(title: item.title, elevation: true),
          body: WebWrapper(
              child: MessageBackgroundWidgetContainer(
                darken: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    AspectRatio(
                        aspectRatio: 1, //controller.value.aspectRatio,
                        child: Container(
                            decoration: getBoxDecoration('/${response.value}'))),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Text(
                              "${response.text}",
                              style: new TextStyle(color: Colors.white, fontSize: 20.0),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Row(
                              children: <Widget>[


                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      // InkWell(
                                      //     child: Icon(
                                      //       Icons.delete,
                                      //       size: 40,
                                      //       color: Colors.white,
                                      //     ),
                                      //     onTap: onDelete)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Text(
                              "${formatter.format(thatTime)}",
                              style: new TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 16.0),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ))),
    );
  }
}
