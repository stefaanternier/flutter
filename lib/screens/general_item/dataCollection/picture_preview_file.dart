import 'dart:io';

import 'package:flutter/material.dart';
import 'package:youplay/screens/general_item/util/messages/components/themed_app_bar.dart';
import 'package:youplay/screens/general_item/util/messages/generic_message.dart';

import '../general_item.dart';

class PictureFilePreview extends StatefulWidget {
  String imagePath;
  final Function submitPicture;
  GeneralItemViewModel giViewModel;

  PictureFilePreview({this.imagePath, this.submitPicture, this.giViewModel});

  @override
  _PictureFilePreviewState createState() => _PictureFilePreviewState();
}

class _PictureFilePreviewState extends State<PictureFilePreview> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemedAppBar(title: widget.giViewModel.item.title, elevation: false),
      body: Container(
        color: Color.fromRGBO(0, 0, 0, 1),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Visibility(
                  visible: widget.giViewModel.item.richText != null,
                  child: Container(
                      color: widget.giViewModel.getPrimaryColor(),
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "${widget.giViewModel.item.richText}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      )),
                ),
                AspectRatio(
                    aspectRatio: 1, //controller.value.aspectRatio,
                    child: Container(
                        decoration: new BoxDecoration(
                            image: new DecorationImage(
                      fit: BoxFit.cover,
                      image: new FileImage(File(widget.imagePath)),
                    )))),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    autofocus: true,
                    textInputAction: TextInputAction.send,
                    controller: myController,
                    onSubmitted: (value) {
                      submitText(value, context);
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),

        ),
      ),
    );
  }

  void submitText(String value, BuildContext context) {
    print("submitting text");
    print(value);
    widget.submitPicture(value);
  }
}

Widget pictureFilePreviewWidget(
    String imagePath, Function submit, Function cancel, BuildContext context) {
  var size = MediaQuery.of(context).size.width;
  return AspectRatio(
      aspectRatio: 1, //controller.value.aspectRatio,
      child: Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
        fit: BoxFit.cover,
//      image: Image.file(File(imagePath))
        image: new FileImage(File(imagePath)),
      ))));

  return Stack(
    alignment: const Alignment(0, 0.9),
    children: [
//      Image.file(File(imagePath)),
      Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
        fit: BoxFit.cover,
//      image: Image.file(File(imagePath))
        image: new FileImage(File(imagePath)),
      ))),
      Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: FloatingActionButton(
                child: Icon(Icons.send),
                onPressed: () {
                  submit();
                }),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: FloatingActionButton(
                child: Icon(Icons.cancel),
                onPressed: () {
                  cancel();
                }),
          )
        ],
      )),
    ],
  );
}
