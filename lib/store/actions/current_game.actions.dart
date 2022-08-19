
import 'package:youplay/models/game.dart';
import 'package:youplay/models/game_theme.dart';

class LoadGameRequestAction {
  int gameId;
  LoadGameRequestAction({required this.gameId});
}

class LoadPublicGameRequestAction {
  int gameId;
  LoadPublicGameRequestAction({required this.gameId});
}

class LoadGameSuccessAction {
  Game game;
  LoadGameSuccessAction({required this.game});

}



class SetCurrentGameAction {
  int currentGame;

  SetCurrentGameAction({required this.currentGame});
}
