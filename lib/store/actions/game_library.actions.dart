import 'package:youplay/models/game.dart';
import 'package:youplay/models/run.dart';

class LoadFeaturedGameAction {

}

class LoadFeaturedGameResultsAction {
  List<Game> games = [];

  LoadFeaturedGameResultsAction({required this.games});
}

class LoadRecentGamesAction {

}

class LoadRecentGameResultsAction {
  List<Game> games = [];

  LoadRecentGameResultsAction({required this.games});
}


class LoadSearchedGameResultsAction {
  List<Game> games=[];

  LoadSearchedGameResultsAction({required this.games});
}

class LoadOneFeaturedGameAction {
  Game game;

  LoadOneFeaturedGameAction({required this.game});
}

class LoadOneFeaturedGameResultAction {
  Game game;
  int rank;
  LoadOneFeaturedGameResultAction({required this.game, required this.rank});
}

class LoadOneFeaturedRunAction {
  Run run;

  LoadOneFeaturedRunAction({required this.run});
}

class ParseLinkAction {
  final String link;

  ParseLinkAction({required this.link});

}

class SearchLibrary {
  String query;

  SearchLibrary({required this.query});
}


