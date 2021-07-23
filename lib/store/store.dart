import 'package:redux/redux.dart';
import 'package:youplay/epics/epics.dart';
import 'package:youplay/store/state/app_state.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:youplay/models/models.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:youplay/store/reducers/reducer.dart';

Future<Store<AppState>> createStore() async {
  final persistor = Persistor<AppState>(
      storage: FlutterStorage(),
      serializer: JsonSerializer<AppState>(AppState.fromJson),
      throttleDuration: new Duration(seconds: 10));
  AppState demo = AppState.emptyState();
  try {
    demo = await persistor.load() ?? demo;
  } catch (e) {
    print("no state");
  }

  return Store<AppState>(
      appReducer,
      middleware: [epicMiddleware], // , persistor.createMiddleware()
      distinct: true,
      initialState: demo);
}
