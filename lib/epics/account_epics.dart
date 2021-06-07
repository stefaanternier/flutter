import 'package:youplay/api/account.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:youplay/actions/actions.dart';
import 'package:youplay/actions/games.dart';
import 'package:youplay/store/state/app_state.dart';

//final accountDetailsEpic = new TypedEpic<AppState, ApiAccountDetailsAction>(accountDetails);

//Stream<dynamic> accountDetails(
//    Stream<dynamic> actions, EpicStore<AppState> store) {
//  return actions.where((action) => action is ApiAccountDetailsAction).asyncMap(
//          (action) => AccountApi.accountDetails()
//          .then((results) => new AccountResultAction(results))
//          .catchError((error) => new MyGamesResultsAction(error)));
//}
