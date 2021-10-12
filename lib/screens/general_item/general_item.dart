
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:youplay/actions/games.dart';
import 'package:youplay/actions/run_actions.dart';
import 'package:youplay/actions/ui.dart';
import 'package:youplay/config/app_config.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/general_item.dart';
import 'package:youplay/models/general_item/audio_object.dart';
import 'package:youplay/models/general_item/combination_lock.dart';
import 'package:youplay/models/general_item/multiple_choice_image.dart';
import 'package:youplay/models/general_item/open_url.dart';
import 'package:youplay/models/general_item/scan_tag.dart';
import 'package:youplay/models/general_item/single_choice.dart';
import 'package:youplay/models/general_item/single_choice_image.dart';
import 'package:youplay/models/run.dart';
import 'package:youplay/screens/general_item/util/messages/audio_object.dart';
import 'package:youplay/screens/general_item/util/messages/combination_lock.dart';
import 'package:youplay/screens/general_item/util/messages/components/next_button.dart';
import 'package:youplay/screens/general_item/util/messages/generic_message.dart';
import 'package:youplay/screens/general_item/util/messages/multiple_choice.dart';
import 'package:youplay/screens/general_item/util/messages/multiple_choice_image.dart';
import 'package:youplay/screens/general_item/util/messages/narrator_item.dart';
import 'package:youplay/screens/general_item/util/messages/record_audio_question.dart';
import 'package:youplay/screens/general_item/util/messages/record_video_question.dart';
import 'package:youplay/screens/general_item/util/messages/scan_tag.dart';
import 'package:youplay/screens/general_item/util/messages/single_choice.dart';
import 'package:youplay/screens/general_item/util/messages/single_choice_image.dart';
import 'package:youplay/screens/general_item/util/messages/take_picture_question.dart';
import 'package:youplay/screens/general_item/util/messages/text_question.dart';
import 'package:youplay/screens/general_item/util/messages/video_object_new.dart';
import 'package:youplay/selectors/selectors.dart';
import 'package:youplay/store/actions/current_run.actions.dart';
import 'package:youplay/store/selectors/current-run.items.selectors.dart';
import 'package:youplay/store/selectors/current_game.selectors.dart';
import 'package:youplay/store/selectors/current_run.selectors.dart';
import 'package:youplay/store/selectors/game_messages.selector.dart';
import 'package:youplay/store/state/app_state.dart';

import '../../localizations.dart';
import 'util/messages/open_url_widget.dart';

class ButtonAction {
  late String to;
  late String action;

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
  Game? game;
  Run? run;
  GeneralItem? item;
  GeneralItem? nextItem;
  int? nextItemId;
  int amountOfNewItems;
  Function continueToNextItem;
  Function continueToNextItemWithTag;

  // Function openScanner;
  // Function toMap;
  Function deleteResponse; //todo delete here, handled elsewhere
  Color? itemPrimaryColor;
  Color? themePrimaryColor;

  GeneralItemViewModel(
      {this.game,
      this.run,
      this.item,
      required this.onTakePictureClick,
      required this.onCancel,
      required this.onDispatch,
      required this.deleteResponse,
//      this.openScanner,
      required this.continueToNextItem,
//      this.toMap,
      required this.continueToNextItemWithTag,
      this.nextItemId,
      this.nextItem,
      required this.amountOfNewItems,
      this.itemPrimaryColor,
      this.themePrimaryColor});

  Function onTakePictureClick;
  Function onCancel;
  Function onDispatch;

  static GeneralItemViewModel fromStore(Store<AppState> store) {
    GeneralItem? item = currentGeneralItem(store.state);
    int? nextItemInt = nextItem1(store.state);
    int amountOfNewItems = amountOfNewerItems(store.state);
    Run? r = currentRunSelector(store.state.currentRunState);
    return new GeneralItemViewModel(
        game: gameSelector(store.state.currentGameState),
        itemPrimaryColor: currentGeneralItem(store.state)?.primaryColor,
        themePrimaryColor:
            gameThemePrimaryColorSelector(store.state.currentGameState),
//        game: currentGameSelector(store.state),
        run: r,
        item: item,
        amountOfNewItems: amountOfNewItems,
        nextItem: nextItemObject(store.state),
        onDispatch: (action) => store.dispatch(action),
        onTakePictureClick: () {
          if (item != null) {
            store.dispatch(GeneralItemTakePicture(item: item));
          }
        },
        onCancel: () {
          store.dispatch(GeneralItemCancelDataCollection());
        },
        deleteResponse: (int responseId) {
          store.dispatch(DeleteResponseFromServer(responseId: responseId));
        },
        nextItemId: nextItemInt,
        continueToNextItem: (BuildContext context) {
          //todo... delete this method
          ButtonAction? ba = null;
          if (item?.description != null && item!.description.contains("::")) {
            int index = item.description.indexOf("::");
            String action = item.description.substring(index + 2);
            ba = new ButtonAction(action);
          }
          if (ba != null) {
            if (ba.isToMap()) {
              if (item != null) {

                // store.dispatch(new ToggleMessageViewAction(
                //     gameId: item.gameId, messageView: MessageView.mapView));
              }

              Navigator.pop(context);
              return true;
            }
            if (ba.isToList()) {
              if (item != null) {
                // store.dispatch(new ToggleMessageViewAction(
                //     gameId: item.gameId, messageView: MessageView.listView));
              }

              Navigator.pop(context);
              return true;
            }
            if (ba.isToItem()) {
              store.dispatch(SetCurrentGeneralItemId(ba.getItemId()));
              return true;
            }
          } else if (nextItemInt != null) {
            if (amountOfNewItems > 1) {
              Navigator.pop(context);
              return true;
            } else {
              if (r != null && r.runId != null) {
                store.dispatch(new ReadItemAction(
                    runId: r.runId!, generalItemId: nextItemInt));
              }

              store.dispatch(SetCurrentGeneralItemId(nextItemInt));
              return true;
            }
          }
          return false;
        },
        continueToNextItemWithTag: (tag) {
          int? itemId = nextItemWithTag(tag)(store.state);
          if (itemId != null) {
            if (r != null && r.runId != null) {
              store.dispatch(
                  new ReadItemAction(runId: r.runId!, generalItemId: itemId));
            }
            store.dispatch(SetCurrentGeneralItemId(itemId));
            return true;
          }
          return false;
        });
  }

  Color getPrimaryColor() {
    return itemPrimaryColor ??
        themePrimaryColor ??
        AppConfig().themeData!.primaryColor;
  }
}

class GeneralItemScreen extends StatelessWidget {
//  final Store<AppState> store;

  GeneralItemScreen();

  Widget buildMessages(BuildContext context, GeneralItemViewModel giViewModel) {
    GeneralItem? item = giViewModel.item;
    if (item == null) {
      return Container(
        width: 0.0,
        height: 0.0,
        child: new Text("no item loaded"),
      );
    }
    GeneralItem notNullItem = item;
    //print("item type ${giViewModel.item.type}");

    switch (notNullItem.type) {
      case ItemType.narrator:
        if (notNullItem.openQuestion != null &&
            (notNullItem.openQuestion!.withPicture ?? false)) {
          return new NarratorWithPicture(
              item: notNullItem, giViewModel: giViewModel);
        }
        return NarratorItemWidget(item: notNullItem, giViewModel: giViewModel);
      case ItemType.openurl:
        return OpenUrlWidget(
            item: (notNullItem as OpenUrl), giViewModel: giViewModel);
      case ItemType.audio:
      //   AudioObjectGeneralItemScreen returnWidget =
      //       AudioObjectGeneralItemScreen(
      //           item: (notNullItem as AudioObjectGeneralItem),
      //           giViewModel: giViewModel,
      //           key: Key('${item.itemId}'));
      //   return returnWidget;

        case ItemType.combinationlock:
        return CombinationLockWidget(
            item: notNullItem as CombinationLockGeneralItem,
            giViewModel: giViewModel,
            key: Key('${notNullItem.itemId}'));
      case ItemType.scanTag:
        return ScanTagWidget(
            item: (notNullItem as ScanTagGeneralItem),
            giViewModel: giViewModel);
        break;
      case ItemType.multiplechoice:
        return MultipleChoiceWidget(
            item: (notNullItem as MultipleChoiceGeneralItem),
            giViewModel: giViewModel,
            key: Key('${notNullItem.itemId}'));
      case ItemType.singlechoice:
        return SingleChoiceWidget(
            item: notNullItem as SingleChoiceGeneralItem,
            giViewModel: giViewModel,
            key: Key('${notNullItem.itemId}'));



      case ItemType.video:
        VideoObjectNew? returnWidget;
        String? unencPath;
        if (item.fileReferences != null) {
          unencPath = item.fileReferences!['video']?.replaceFirst('//', '/');
        }
        if (unencPath != null) {
          int index = unencPath.lastIndexOf("/") + 1;
          String path;
          if (UniversalPlatform.isIOS) {
            path = Uri.encodeComponent(unencPath);

          } else {
            path = unencPath.substring(0, index) +
                Uri.encodeComponent(unencPath.substring(index));
          }
          FirebaseStorage.instance.ref(path).getDownloadURL().then((url) {
            print('url is $url');

          });
          //'https://firebasestorage.googleapis.com/v0/b/serious-gaming-platform.appspot.com/o/game%2F5637749142978560%2Fnospaces%2Fwelkom.mp4?alt=media&token=28ed18e8-9adb-414c-b9f9-05312afde85c',
          returnWidget = new VideoObjectNew(
              key: Key('${item.itemId}'),
            url:
                'https://storage.googleapis.com/${AppConfig().projectID}.appspot.com${path}',
            color: giViewModel.getPrimaryColor(),
            onFinishedPlaying: () {
              if (giViewModel.item != null && giViewModel.run?.runId != null) {
                giViewModel.onDispatch(Complete(
                  generalItemId: giViewModel.item!.itemId,
                  runId: giViewModel.run!.runId!,
                ));
              }
            },
            showOnFinish: NextButton(
                buttonText: item.description != ""
                    ? item.description
                    : AppLocalizations.of(context).translate('screen.proceed'),
                overridePrimaryColor: giViewModel.getPrimaryColor(),
                giViewModel: giViewModel),
          );
        }

        return GeneralItemWidget(
            item: item,
            renderBackground: false,
            giViewModel: giViewModel,
            body: Container(
                constraints: const BoxConstraints.expand(),
                child: returnWidget ??
                    Theme(
                      data: Theme.of(context)
                          .copyWith(accentColor: giViewModel.getPrimaryColor()),
                      child: Center(child: CircularProgressIndicator()),
                    ))
        );

      // VideoObjectGeneralItemScreen returnWidget =
      // VideoObjectGeneralItemScreen(
      //     item: (item as VideoObjectGeneralItem),
      //     giViewModel: giViewModel,
      //     key: Key('${item.itemId}'));




      case ItemType.singlechoiceimage:
        return SingleChoiceWithImage(
            item: (notNullItem as SingleChoiceImageGeneralItem),
            giViewModel: giViewModel,
            key: Key('${item.itemId}'));
        break;
      case ItemType.multiplechoiceimage:
        return MultipleChoiceWithImage(
            item: (notNullItem as MultipleChoiceImageGeneralItem),
            giViewModel: giViewModel,
            key: Key('${item.itemId}'));
        break;

      case ItemType.picturequestion:
        return new NarratorWithPicture(
            item: notNullItem, giViewModel: giViewModel);
        break;
      case ItemType.audioquestion:
        return new NarratorWithAudio(
            item: notNullItem, giViewModel: giViewModel);
        break;
      case ItemType.textquestion:
        return new TextQuestionScreen(
            item: notNullItem, giViewModel: giViewModel);
        break;

      case ItemType.videoquestion:
        return new NarratorWithVideo(
            item: notNullItem, giViewModel: giViewModel);
        break;
    }
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
