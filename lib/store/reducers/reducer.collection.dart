import 'package:redux/redux.dart';
import 'package:youplay/store/actions/actions.collection.dart';
import 'package:youplay/store/state/state.collection.dart';

final collectionReducer = combineReducers<CollectionState>([
  TypedReducer<CollectionState, LoadRecentGamesSuccess>((CollectionState state, LoadRecentGamesSuccess action) => state.copyWithGames(action.gameList.items)),
  TypedReducer<CollectionState, LoadPublicGameSuccess>((CollectionState state, LoadPublicGameSuccess action) => state.copyWithGame(action.game)),
  TypedReducer<CollectionState, LoadFeaturedGameSuccess>((CollectionState state, LoadFeaturedGameSuccess action) => state.copyWithFeatured(action.gameList.items)),

]);
