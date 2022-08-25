import 'package:redux/redux.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:youplay/models/models.dart';
import 'package:youplay/store/middlewares/epics.dart';
import 'package:youplay/store/reducers/reducer.dart';
import 'package:youplay/store/state/app_state.dart';

Future<Store<AppState>> createStore() async {
  final persistor = Persistor<AppState>(
      storage: FlutterStorage(),
      serializer: JsonSerializer<AppState>(AppState.fromJson),
      throttleDuration: new Duration(seconds: 10));
  AppState demo = AppState.emptyState();
  try {
    print('loading from persistor');
    // demo = await persistor.load() ?? demo; //todo switch on later
  } catch (e) {
    print("no state $e");
  }

  return Store<AppState>(appReducer,
      middleware: [epicMiddleware, persistor.createMiddleware()], // ,
      distinct: true,
      initialState: demo);
}
