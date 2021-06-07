import 'dart:io';

import 'package:youplay/actions/games.dart';
import 'package:youplay/actions/run_actions.dart';
import 'package:youplay/actions/runs.dart';
import 'package:youplay/actions/ui.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/general_item/open_url.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/screens/general_item/dataCollection/data_collection_nav_bar.dart';
import 'package:youplay/screens/general_item/dataCollection/outgoing_picture_response_list.dart';
import 'package:youplay/screens/general_item/dataCollection/outgoing_responses_list.dart';
import 'package:youplay/screens/general_item/dataCollection/take_picture.dart';
import 'package:youplay/screens/general_item/util/gi_header.dart';
import 'package:youplay/screens/general_item/util/messages/audio_object.dart';
import 'package:youplay/screens/general_item/util/messages/combination_lock.dart';
import 'package:youplay/screens/general_item/util/messages/multiple_choice.dart';
import 'package:youplay/screens/general_item/util/messages/multiple_choice_image.dart';
import 'package:youplay/screens/general_item/util/messages/narrator_item.dart';
import 'package:youplay/screens/general_item/util/messages/record_audio_question.dart';
import 'package:youplay/screens/general_item/util/messages/record_video_question.dart';
import 'package:youplay/screens/general_item/util/messages/take_picture_question.dart';
import 'package:youplay/screens/general_item/util/messages/scan_tag.dart';
import 'package:youplay/screens/general_item/util/messages/single_choice.dart';
import 'package:youplay/screens/general_item/util/messages/single_choice_image.dart';
import 'package:youplay/screens/general_item/util/messages/text_question.dart';
import 'package:youplay/screens/general_item/util/messages/video_object.dart';
import 'package:youplay/screens/util/ARLearnContainer.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/actions/ui_actions.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/state/run_state.dart';
import 'package:youplay/state/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:youplay/selectors/ui_selectors.dart';
import 'package:youplay/selectors/selectors.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';

import 'util/messages/open_url_widget.dart';

class ButtonAction {
  String to;
  String action;

  ButtonAction(String fullAction) {
    int index = fullAction.indexOf(":");
    if (index < 0) {
      this.to = fullAction;
      this.action = "";
    } else {
      this.to = fullAction.substring(0, index);
      this.action = fullAction.substring(index + 1);
    }
  }

  @override
  String toString() {
    // TODO: implement toString
    return this.to + " -- " + action;
    ;
  }

  bool isToMap() {
    return this.to == 'toMap';
  }

  bool isToList() {
    return this.to == 'toList';
  }

  bool isToItem() {
    return this.to == 'to';
  }

  int getItemId() {
    return int.parse(action);
  }
}

class GeneralItemViewModel {
  Game game;
  Run run;
  GeneralItem item;
  GeneralItem nextItem;
  int nextItemId;
  int amountOfNewItems;
  Function continueToNextItem;
  Function continueToNextItemWithTag;
  Function openScanner;
  Function toMap;
  Function deleteResponse;
  Color itemPrimaryColor;
  Color themePrimaryColor;

  GeneralItemViewModel(
      {this.game,
      this.run,
      this.item,
      this.onTakePictureClick,
      this.onCancel,
      this.onDispatch,
      this.deleteResponse,
//      this.openScanner,
      this.continueToNextItem,
//      this.toMap,
      this.continueToNextItemWithTag,
      this.nextItemId,
      this.nextItem,
        this.amountOfNewItems,
      this.itemPrimaryColor,
      this.themePrimaryColor});

  Function onTakePictureClick;
  Function onCancel;
  Function onDispatch;

  static GeneralItemViewModel fromStore(Store<AppState> store) {
    GeneralItem item = currentGeneralItem(store.state);
    int nextItemInt = nextItem1(store.state);
    int amountOfNewItems = amountOfNewerItems(store.state);
    Run r = currentRunSelector(store.state.currentRunState);
    return new GeneralItemViewModel(
        game: gameSelector(store.state.currentGameState),
        itemPrimaryColor: currentGeneralItem(store.state).primaryColor,
        themePrimaryColor: gameThemePrimaryColorSelector(store.state.currentGameState),
//        game: currentGameSelector(store.state),
        run: r,
        item: item,
        amountOfNewItems: amountOfNewItems,
        nextItem: nextItemObject(store.state),
        onDispatch: (action) => store.dispatch(action),
        onTakePictureClick: () {
          store.dispatch(GeneralItemTakePicture(item: item));
        },
        onCancel: () {
          store.dispatch(GeneralItemCancelDataCollection());
        },
        deleteResponse: (int responseId) {
          store.dispatch(DeleteResponseFromServer(responseId: responseId));
        },
        nextItemId: nextItemInt,
        continueToNextItem: (BuildContext context) {
          ButtonAction ba = null;
          if (item.description != null && item.description.contains("::")) {
            int index = item.description.indexOf("::");
            String action = item.description.substring(index + 2);
            ba = new ButtonAction(action);
//            print("action is ${ba.toString()}");
          }
          if (ba != null) {
            if (ba.isToMap()) {
              store.dispatch(new ToggleMessageViewAction(
                  gameId: item.gameId, messageView: MessageView.mapView));
              Navigator.pop(context);
              return true;
            }
            if (ba.isToList()) {
              store.dispatch(new ToggleMessageViewAction(
                  gameId: item.gameId, messageView: MessageView.listView));
              Navigator.pop(context);
              return true;
            }
            if (ba.isToItem()) {
              store.dispatch(SetCurrentGeneralItemId(ba.getItemId()));
              return true;
            }
          } else if (nextItemInt != null) {
            if (amountOfNewItems > 1){
              Navigator.pop(context);
              return true;
            } else {
              store.dispatch(new ReadItemAction(runId: r.runId, generalItemId: nextItemInt));

              store.dispatch(SetCurrentGeneralItemId(nextItemInt));
              return true;
            }

          }
          return false;
        },
        continueToNextItemWithTag: (tag) {
          int itemId = nextItemWithTag(tag)(store.state);
          if (itemId != null) {
            store.dispatch(new ReadItemAction(runId: r.runId, generalItemId: itemId));
            store.dispatch(SetCurrentGeneralItemId(itemId));
            return true;
          }
          return false;
        });
  }

  Color getPrimaryColor() {
    if (itemPrimaryColor != null) {
      return itemPrimaryColor;
    }
    return themePrimaryColor;
  }
}

//class GeneralItemScreen extends StatefulWidget {
//  GeneralItemScreen({Key key}) : super(key: key);
//
//  @override
//  _GeneralItemScreenState createState() => _GeneralItemScreenState();
//}
//State<GeneralItemScreen> {
class GeneralItemScreen extends StatelessWidget {
//  final Store<AppState> store;

  GeneralItemScreen();

  Widget buildMessages(BuildContext context, GeneralItemViewModel giViewModel) {
    GeneralItem item = giViewModel.item;
    //print("item type ${giViewModel.item.type}");
    switch (giViewModel.item.type) {
      case ItemType.narrator:
        if (item.openQuestion != null && item.openQuestion.withPicture) {
          return new NarratorWithPicture(item: item, giViewModel: giViewModel);
        }
        return NarratorItemWidget(item: item, giViewModel: giViewModel);
        break;
      case ItemType.openurl:

        return OpenUrlWidget(item: (item as OpenUrl), giViewModel: giViewModel);
        break;
      case ItemType.audio:
        AudioObjectGeneralItemScreen returnWidget = AudioObjectGeneralItemScreen(
            item: item, giViewModel: giViewModel, key: Key('${item.itemId}'));

        return returnWidget;
        break;
      case ItemType.video:
        VideoObjectGeneralItemScreen returnWidget = VideoObjectGeneralItemScreen(
            item: item, giViewModel: giViewModel, key: Key('${item.itemId}'));

        return returnWidget;
      case ItemType.combinationlock:
        return CombinationLockWidget(item: item, giViewModel: giViewModel, key: Key('${item.itemId}'));
        case ItemType.singlechoice:
        return SingleChoiceWidget(item: item, giViewModel: giViewModel, key: Key('${item.itemId}'));
      case ItemType.multiplechoice:
        return MultipleChoiceWidget(
            item: item, giViewModel: giViewModel, key: Key('${item.itemId}'));
      case ItemType.scanTag:
        return ScanTagWidget(item: item, giViewModel: giViewModel);
        break;
      case ItemType.singlechoiceimage:
        return SingleChoiceWithImage(
            item: item, giViewModel: giViewModel, key: Key('${item.itemId}'));
        break;
      case ItemType.multiplechoiceimage:
        return MultipleChoiceWithImage(
            item: item, giViewModel: giViewModel, key: Key('${item.itemId}'));
        break;
      case ItemType.picturequestion:
        return new NarratorWithPicture(item: item, giViewModel: giViewModel);
        break;
      case ItemType.audioquestion:
        return new NarratorWithAudio(item: item, giViewModel: giViewModel);
        break;
      case ItemType.textquestion:
        return new TextQuestionScreen(item: item, giViewModel: giViewModel);
        break;
      case ItemType.videoquestion:
        return new NarratorWithVideo(item: item, giViewModel: giViewModel);
        break;
    }
    return Container(
      width: 0.0,
      height: 0.0,
      child: new Text("test ${giViewModel.item}"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, GeneralItemViewModel>(
        converter: (store) => GeneralItemViewModel.fromStore(store),
        builder: (context, GeneralItemViewModel state) {
          return buildMessages(context, state);

//            Scaffold(
//            body: _buildBody(context, state),
//            bottomNavigationBar: state.item.openQuestion != null
//                ? DataCollectionNavBar(
//                    color: Colors.grey,
//                    selectedColor: Colors.red,
//                    notchedShape: CircularNotchedRectangle(),
//                    openQuestion: state.item.openQuestion,
//
//                  )
//                : null,
//            floatingActionButtonLocation:
//                FloatingActionButtonLocation.endDocked,
//            floatingActionButton: state.item.openQuestion != null && ItemUiState.itemView == state.uiViewState
//                ? DataCollectionFAB(
//                    show: ItemUiState.itemView == state.uiViewState,
//                    openQuestion: state.item.openQuestion,
//                    onTakePictureSelected: state.onTakePictureClick)
//                : null,
////            floatingActionButton:FloatingActionButton(
////              tooltip: 'Increment',
////              child: Icon(Icons.add),
////              elevation: 2.0,
////              onPressed: (){
////                print("im pressed");
////
////              },
////            ),
//          );
        });
  }
}
