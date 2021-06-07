import 'package:youplay/models/game.dart';

//todo delete
class Library {
  List<Game> featuredGames;
  List<Category> categories;

  Library({this.featuredGames, this.categories});

  factory Library.demoState() => new Library(
      featuredGames: new List<Game>()..add(new Game(gameId: 1, theme: 0)),
      categories: new List<Category>()
        ..add(new Category(lang: 'nl', label: 'cultuur'))
        ..add(new Category(lang: 'nl', label: 'language learning')));
}

class Category {
  String lang;
  String label;
  List<Game> games;
  Category({this.lang, this.label});
}

class LibrarySearch {
  String searchTerms;
  List<Game> results;
}
