import 'package:youplay/models/game.dart';

class LoadFeaturedGameRequest {
  LoadFeaturedGameRequest();
}

class LoadFeaturedGameSuccess {
  GameList gameList;
  LoadFeaturedGameSuccess({required this.gameList});
}
