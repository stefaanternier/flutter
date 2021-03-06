
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:youplay/actions/run_actions.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/response.dart';
import 'package:youplay/screens/components/button/cust_flat_button.dart';
import 'package:youplay/screens/components/button/cust_raised_button.dart';
import 'package:youplay/screens/general_item/general_item.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/current_run.picture.actions.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/state/app_state.dart';

import '../../../../localizations.dart';
import 'components/game_themes.viewmodel.dart';
import 'components/next_button.dart';
import 'generic_message.dart';

class _TextInputViewModel {
  List<String> keys;
  List<Response> audioResponses;
  List<Response> fromServer;

  _TextInputViewModel({this.keys, this.audioResponses, this.fromServer});

  static _TextInputViewModel fromStore(Store<AppState> store, GeneralItem item) {
    return new _TextInputViewModel(
        audioResponses: currentRunResponsesSelector(store.state).where((element) => element.item.itemId == item.itemId).toList(growable: false),
        fromServer: currentItemResponsesFromServerAsList(store.state));
  }

  int amountOfItems() {
    return audioResponses.length + fromServer.length;
  }

  bool isLocal(int index) {
    return index >= fromServer.length;
  }

  Response getItem(index) {
    fromServer.sort((a, b)=> b.timestamp.compareTo(a.timestamp));
    if (index < fromServer.length) {
      return fromServer[index];
    }
    return audioResponses[index - fromServer.length];
  }

  Response delete(index) {
    if (index < fromServer.length) {
      return fromServer.removeAt(index);
    } else {
      return audioResponses.removeAt(index - fromServer.length);
    }
  }

  void deleteAllResponses(List<Response> deleted) {
    this.fromServer = this.fromServer.where((element) {
      for (var i = 0; i < deleted.length; ++i) {
        var o = deleted[i];
        if (deleted[i].responseId == element.responseId) return false;
      }
      return true;
    }).toList(growable: true);
    this.audioResponses = this.audioResponses.where((element) {
      for (var i = 0; i < deleted.length; ++i) {
        var o = deleted[i];
        if (deleted[i].responseId == element.responseId) return false;
      }
      return true;
    }).toList(growable: true);
  }
}

class TextQuestionScreen extends StatefulWidget {
  GeneralItem item;
  GeneralItemViewModel giViewModel;

  TextQuestionScreen({this.item, this.giViewModel});

  @override
  _TextQuestionState createState() => new _TextQuestionState();
}

class _TextQuestionState extends State<TextQuestionScreen> {
  List<Response> deleted = [];
  final myController = TextEditingController();
  int selectedItem = -1;
  bool showList = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (showList) {
      return buildListOverview(context);
    }

    Widget body = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        new StoreConnector<AppState, GameThemesViewModel>(
            converter: (store) => GameThemesViewModel.fromStore(store),
            builder: (context, GameThemesViewModel themeModel) {
              return Container(
                  // color: this.widget.giViewModel.getPrimaryColor(),
                  color: this.widget.giViewModel.getPrimaryColor() != null
                      ? this.widget.giViewModel.getPrimaryColor()
                      : themeModel.getPrimaryColor(),
                  child: this.widget.item.richText==null?Container():Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "${this.widget.item.richText}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ));
            }),
        Flexible(
            flex: 1,
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
                  ),
                ))),
      ],
    );
    return GeneralItemWidget(
        item: this.widget.item,
        giViewModel: this.widget.giViewModel,
        padding: false,
        elevation: false,
        body: Container(color: Color.fromRGBO(0, 0, 0, 1), child: body));
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void submitText(String value, BuildContext context) {
    widget.giViewModel.onDispatch(TextResponseAction(
        textResponse: Response(run: widget.giViewModel.run, item: widget.item, value: value)));
    widget.giViewModel.onDispatch(LocalAction(
      action: "answer_given",
      generalItemId: widget.giViewModel.item.itemId,
      runId: widget.giViewModel.run.runId,
    ));
    widget.giViewModel.onDispatch(LocalAction(
      action: value.toLowerCase().trim().replaceAll(' ', ''),
      generalItemId: widget.giViewModel.item.itemId,
      runId: widget.giViewModel.run.runId,
    ));
    widget.giViewModel.onDispatch(SyncFileResponse(runId: widget.giViewModel.run.runId));
    // Navigator.of(context).pop();
    setState(() {
      showList = true;
    });
  }

  Widget buildListOverview(BuildContext context) {
    return GeneralItemWidget(
        item: this.widget.item,
        giViewModel: this.widget.giViewModel,
        padding: false,
        elevation: false,
        body: Container(
            color: Color.fromRGBO(0, 0, 0, 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new StoreConnector<AppState, GameThemesViewModel>(
                    converter: (store) => GameThemesViewModel.fromStore(store),
                    builder: (context, GameThemesViewModel themeModel) {
                      return Container(
                          // color: this.widget.giViewModel.getPrimaryColor(),
                          color: this.widget.giViewModel.getPrimaryColor() != null
                              ? this.widget.giViewModel.getPrimaryColor()
                              : themeModel.getPrimaryColor(),
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child:this.widget.item.richText==null?Container(): Text(
                              "${this.widget.item.richText}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ));
                    }),
                Expanded(
                  child: StoreConnector<AppState, _TextInputViewModel>(
                      converter: (store) => _TextInputViewModel.fromStore(store, widget.item),
                      builder: (context, _TextInputViewModel map) {
//                print("map is back ${map.amountOfItems()}");
                        map.deleteAllResponses(this.deleted);
//                print("map is back ${map.amountOfItems()}");
                        final DateTime now = DateTime.now();
//                final DateFormat formatter = DateFormat('yyyy-MM-dd');
                        final DateFormat formatter =
                            DateFormat.yMMMMd(Localizations.localeOf(context).languageCode);
                        return ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.grey,
                          ),
                          itemCount: map.amountOfItems(),
                          itemBuilder: (context, index) {
                            final DateTime thatTime =
                                DateTime.fromMillisecondsSinceEpoch(map.getItem(index).timestamp);
                            return Dismissible(
                                key: Key('${map.getItem(index).timestamp}'),
                                background: slideLeftBackground(),
                                onDismissed: (direction) {
                                  setState(() {
                                    this.deleted.add(map.getItem(index));
                                    deleteResponse(map.delete(index));
                                    map.deleteAllResponses(this.deleted);
                                  });
                                },
                                child: ListTile(
                                  title:
                                      Text("${map.getItem(index).value}", style: TextStyle(color: Colors.white)),
                                  trailing: Text('${formatter.format(thatTime)} ',
                                      style: TextStyle(color: Colors.white.withOpacity(0.7))),

                                ));
                          },
                        );
                      }),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(46, 8.0, 46, 8),
                    child: NextButton(
                        buttonText: AppLocalizations.of(context).translate('screen.proceed'),
                        overridePrimaryColor: widget.giViewModel.getPrimaryColor(),
                        customButton:
                        CustomRaisedButton(
                          title: AppLocalizations.of(context).translate('screen.proceed'),
                          // icon: new Icon(Icons.play_circle_outline, color: Colors.white),
                          onPressed: () {
                            widget.giViewModel.continueToNextItem(context);
                          },
                          primaryColor: widget.giViewModel.getPrimaryColor(),
                          useThemeColor: true,
                        ),
                        giViewModel: widget.giViewModel)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(46, 8.0, 46, 28),
                  child: CustomFlatButton(
                    title: "Nieuwe tekst", //todo vertaal
                    icon: FontAwesomeIcons.pen,
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        showList = false;
                        myController.text = "";
                      });
                    },
                  ),
                ),
              ],
            )));


  }


  deleteResponse(Response item) {
    if (item.responseId != null) {
      widget.giViewModel.deleteResponse(item.responseId);
    }
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }
}
