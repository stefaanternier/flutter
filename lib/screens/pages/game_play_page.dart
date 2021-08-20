import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:youplay/screens/ui_models/current_game_view_model.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/ui/components/game_play/game_over.container.dart';
import 'package:youplay/ui/components/game_play/message_list.container.dart';
import 'package:youplay/ui/components/game_play/toggle_view_button.container.dart';
import 'package:youplay/ui/components/nav/navigation_drawer.container.dart';

//todo delete

class GamePlayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, CurrentGameViewModel>(
        converter: (store) => CurrentGameViewModel.fromStore(store),
        builder: (context, CurrentGameViewModel currentGameViewModel) {
          Scaffold scaffold = Scaffold(
            drawer: ARLearnNavigationDrawerContainer(),
            appBar: AppBar(
              backgroundColor:
                  currentGameViewModel.themedAppBarViewModel.getPrimaryColor(),
              title: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  "${currentGameViewModel.game?.title ?? ''}",
                  // maxLines: 1,
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
              actions: UniversalPlatform.isWeb
                  ? null
                  : [ToggleViewButtonContainer()],
            ),
            body: currentGameViewModel.finished
                ? GameOverContainer()
                : Center(child: _buildMessages(currentGameViewModel)),
          );
          return scaffold;
        });
  }

  Widget _buildMessages(CurrentGameViewModel currentGameViewModel) {
    if (currentGameViewModel.run == null) {
      return _buildWaitingRoom();
    }
    return _buildWaitingRoom();
    return MessageListContainer();
  }

  Widget _buildWaitingRoom() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
              child: Text(
            "Even geduld, we laden de run",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFFA0ABB5),
              fontSize: 20.0,
            ),
          )),
        ],
      ),
    );
    return Text("even geduld, we laden de run...");
  }
}
