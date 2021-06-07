// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/response.dart';

class DisplayOnePicture extends StatefulWidget {
  Response currentResponse;
  Function close;

  DisplayOnePicture({this.currentResponse, this.close});

  @override
  _DisplayOnePictureState createState() => _DisplayOnePictureState();
}

class _DisplayOnePictureState extends State<DisplayOnePicture> {
String label;
  TextEditingController labelController;
  void initState() {
    labelController = TextEditingController(text: 'Nieuwe opname');
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child:
      CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: <Widget>[
                // AspectRatio(
                //   aspectRatio: 1,
                //   child: new CachedNetworkImage(
                //       fit: BoxFit.cover,
                //       imageUrl:
                //       "https://storage.googleapis.com/${AppConfig().projectID}.appspot.com/${widget.currentResponse.value}"),
                // ),
                // Expanded(child: Container(color: Colors.red)),
                new TextField(
                  controller: labelController,
                  maxLength: 1,
                  cursorColor: Colors.white,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                  onTap: () {
                    //widget.onPressed(true);
                  },
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
 print('text is now ${this.label}');
                  },
                  onChanged: (String text) {
                    setState(() {

                      this.label = text;
                    });
                    //widget.changeEmail(text);
                  },
                ),
              ],
            ),
          ),
        ],
      )




      // SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       AspectRatio(
      //         aspectRatio: 1,
      //         child: new CachedNetworkImage(
      //             fit: BoxFit.cover,
      //             imageUrl:
      //                 "https://storage.googleapis.com/${AppConfig().projectID}.appspot.com/${widget.currentResponse.value}"),
      //       ),
      //       new TextField(
      //         controller: labelController,
      //         maxLength: 1,
      //         style: TextStyle(
      //           color: Colors.white,
      //           fontSize: 20.0,
      //         ),
      //         onTap: () {
      //           //widget.onPressed(true);
      //         },
      //         onEditingComplete: () {
      //           FocusScope.of(context).unfocus();
      //         },
      //         onChanged: (String text) {
      //           setState(() {
      //           });
      //           //widget.changeEmail(text);
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  Future<bool> _onBackPressed() async {
    print("on back pressed");
    widget.close();
    return false;
  }
}
