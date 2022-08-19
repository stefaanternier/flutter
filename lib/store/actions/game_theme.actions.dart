import 'package:youplay/models/game_theme.dart';

class LoadGameTheme {
  int themeIdentifier;
  LoadGameTheme({required this.themeIdentifier});


  @override
  bool operator ==(dynamic other) {
    LoadGameTheme o = other as LoadGameTheme;
    return themeIdentifier == o.themeIdentifier;
  }

  @override
  int get hashCode => themeIdentifier.hashCode;
}

class LoadGameThemeSuccess {
  GameTheme gameTheme;
  LoadGameThemeSuccess({required this.gameTheme});
}
