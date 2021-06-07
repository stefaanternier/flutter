import 'package:youplay/api/StoreApi.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:youplay/actions/actions.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:youplay/actions/games.dart';


//Stream<dynamic> storeFeaturedGamesEpic(
//    Stream<dynamic> actions, EpicStore<AppState> store) {
//  //store.state.authentication.idToken
//  return actions.where((action) => action is LoadMyGamesAction).asyncMap(
//          (action) => StoreApi.featuredGames()
//          .then((results) => new MyGamesResultsAction(results))
//          .catchError((error) => new MyGamesResultsAction(error)));
//}
