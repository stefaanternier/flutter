import 'package:youplay/models/game_theme.dart';

class LoadGameTheme {
  int themeIdentifier;
  LoadGameTheme({required this.themeIdentifier});
}

class LoadGameThemeSuccess {
  GameTheme gameTheme;
  LoadGameThemeSuccess({required this.gameTheme});
}
