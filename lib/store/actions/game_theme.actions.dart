import 'package:youplay/models/game_theme.dart';

class LoadGameTheme {
  int themeIdentifier;
  LoadGameTheme({this.themeIdentifier});
}

class LoadGameThemeSuccess {
  GameTheme gameTheme;
  LoadGameThemeSuccess({this.gameTheme});
}
