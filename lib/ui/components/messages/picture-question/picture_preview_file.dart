import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:youplay/models/general_item/narrator_item.dart';
import 'package:youplay/ui/components/appbar/themed-appbar.container.dart';
import 'package:youplay/ui/components/web/web_wrapper.dart';
import 'dart:io' show Platform;

import '../../buttons/cust_flat_button.dart';  //at the top

class PictureFilePreview extends StatefulWidget {
  String imagePath;
  final Function submitPicture;
  final PictureQuestion item;

  PictureFilePreview(
      {required this.imagePath,
      required this.submitPicture,
      required this.item
      });

  @override
  _PictureFilePreviewState createState() => _PictureFilePreviewState();
}

class _PictureFilePreviewState extends State<PictureFilePreview> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String os = Platform.operatingSystem;
    print('${Platform.operatingSystem}');
    print('${Platform.operatingSystemVersion}');
    print('${Platform.environment}');
    print('${Platform.localeName}');
    print('${Platform.localHostname}');
    print('${Platform.version}');

    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, 1),
      appBar: ThemedAppbarContainer(title: widget.item.title, elevation: false),
      body: WebWrapper(
        child: Container(
          color: Color.fromRGBO(0, 0, 0, 1),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Visibility(
                  visible: widget.item.richText != '',
                  child: Container(
                      // color: widget.giViewModel.getPrimaryColor(),
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(widget.item.richText,
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
                if (MediaQuery.of(context).viewInsets.bottom == 0.0)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(46, 8.0, 46, 28),
                    child: CustomFlatButton(
                      title: "Send",
                      icon: FontAwesomeIcons.paperPlane,
                      color: Colors.white,
                      onPressed: () {
                        print('myController.value ${myController.value.text}');
                        submitText(myController.value.text, context);
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submitText(String value, BuildContext context) {
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
