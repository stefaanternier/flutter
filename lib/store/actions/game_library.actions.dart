import 'package:youplay/models/game.dart';
import 'package:youplay/models/run.dart';

class LoadFeaturedGameAction {

}

class LoadFeaturedGameResultsAction {
  List<Game> games = [];

  LoadFeaturedGameResultsAction({this.games});
}

class LoadRecentGamesAction {

}

class LoadRecentGameResultsAction {
  List<Game> games = [];

  LoadRecentGameResultsAction({this.games});
}


class LoadSearchedGameResultsAction {
  List<Game> games=[];

  LoadSearchedGameResultsAction({this.games});
}

class LoadOneFeaturedGameAction {
  Game game;

  LoadOneFeaturedGameAction({this.game});
}

class LoadOneFeaturedGameResultAction {
  Game game;

  LoadOneFeaturedGameResultAction({this.game});
}

class LoadOneFeaturedRunAction {
  Run run;

  LoadOneFeaturedRunAction({this.run});
}

class ParseLinkAction {
  String link;

  ParseLinkAction({this.link});

}

class SearchLibrary {
  String query;

  SearchLibrary({this.query});
}


