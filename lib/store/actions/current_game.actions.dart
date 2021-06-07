
import 'package:youplay/models/game.dart';
import 'package:youplay/models/game_theme.dart';

class LoadGameRequestAction {
  int gameId;
  LoadGameRequestAction(this.gameId);
}

class LoadPublicGameRequestAction {
  int gameId;
  LoadPublicGameRequestAction(this.gameId);
}

class LoadGameSuccessAction {
  Game game;
  GameTheme gameTheme;
  LoadGameSuccessAction({this.game, this.gameTheme});

}



class SetCurrentGameAction {
  int currentGame;

  SetCurrentGameAction(this.currentGame);
}
