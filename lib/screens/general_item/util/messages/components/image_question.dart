import 'dart:math';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/general_item/multiple_choice_image.dart';
import 'package:youplay/screens/components/button/cust_raised_button.container.dart';
import 'package:youplay/screens/util/extended_network_image.dart';
import 'package:youplay/store/state/app_state.dart';

import '../../../../../localizations.dart';
import '../../../general_item.dart';
import 'game_themes.viewmodel.dart';
import 'next_button.dart';

class ImageQuestion extends StatelessWidget {
  String? buttonText; //correct or
  GeneralItem item;
  String? feedback;
  Color? primaryColor;
  Function(String, int?) buttonClick;
  Function() submitClick;
  bool buttonVisible;
  List<ImageChoiceAnswer> answers;
  Map<String, bool> selected;
  GeneralItemViewModel? giViewModel;

  ImageQuestion(
      {required this.item,
      this.primaryColor,
        this.buttonText,
      //required this.primaryColor,
      required this.answers,
      required this.selected,
      required this.buttonVisible,
      required this.buttonClick,
      required this.submitClick,
      this.giViewModel,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, GameThemesViewModel>(
        converter: (store) => GameThemesViewModel.fromStore(store),
        builder: (context, GameThemesViewModel themeModel) {
          return Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Opacity(
                  opacity: 0.9,
                  child:
                      Padding(padding: EdgeInsets.fromLTRB(30, 0, 30, 10), child: buildBottomCard(context, themeModel)))
            ],
          ));
        });
  }

  @override
  Widget buildBottomCard(BuildContext context, GameThemesViewModel themeModel) {
    return Card(
      child: LimitedBox(
        maxHeight: MediaQuery.of(context).size.height * 0.66,
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
                      (index, length) => buildClickArea(getScale(index, length), index, context, themeModel))),
              Visibility(
                visible: buttonVisible,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 12),
                    child: CustomRaisedButtonContainer(
                      title: buttonText ?? 'todo',
                      // primaryColor: widget.overridePrimaryColor != null
                      //     ? widget.overridePrimaryColor
                      //     : this.widget.giViewModel.getPrimaryColor(),
                      onPressed: (){
                        submitClick();
                      },
                    )
                    // NextButton(
                    //   buttonText: item.description != ""
                    //       ? item.description
                    //       : AppLocalizations.of(context)
                    //           .translate('screen.proceed'),
                    //   overridePrimaryColor: giViewModel.getPrimaryColor(),
                    //   giViewModel: giViewModel,
                    //   makeVisible: buttonVisible,
                    //   overrideButtonPress: () {
                    //     submitClick();
                    //   },
                    // ),
                    ),
              ),
            ],
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
                    (rowIndex) => widgetBuilder(colIndex * scale + rowIndex, answers.length))

//                <Widget>[widgetBuilder(colIndex*scale+0),,],
                )));
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

  Widget buildClickArea(double scale, int index, BuildContext context, GameThemesViewModel themeModel) {
    return new Expanded(
        child: AspectRatio(
      aspectRatio: scale,
      child: Padding(
          padding: EdgeInsets.all(4),
          child: GestureDetector(
              onTap: () {
                buttonClick(answers[index].id, index);
//                  setState(() {
//                    _selected[widget.answers[index].id] =
//                    !_selected[widget.answers[index].id];
//                  });
              },
              child: Stack(
                children: [
                  Container(
                    decoration: getBoxDecoration(item.fileReferences?[answers[index].id]),
                  ),
                  Visibility(
                    visible: selected[answers[index].id] ?? false,
                    child: Positioned(
                      top: 5,
                      right: 5,
                      child: Icon(
                        Icons.check_circle,
                        // color: primaryColor, //todo
                      ),
                    ),
                  ),
                  Positioned(
                    left: 5,
                    bottom: 5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2.0),
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: Stack(
                          alignment: const Alignment(0, 0),
                          children: [
                            Container(
                                // color: primaryColor, //todo
                                ),
                            Center(
                              child: Text('${index + 1}', style: TextStyle(color: Colors.white)),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ))),
    ));
  }
}
