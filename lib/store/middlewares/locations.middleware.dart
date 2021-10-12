import 'package:location/location.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youplay/actions/run_actions.dart';
import 'package:youplay/screens/util/location/gps_utils.dart';
import 'package:youplay/store/actions/locations.actions.dart';
import 'package:youplay/store/selectors/location.selectors.dart';
import 'package:youplay/store/state/app_state.dart';

final locationEpic = combineEpics<AppState>([
  new TypedEpic<AppState, dynamic>(_startListening),
  new TypedEpic<AppState, dynamic>(_processLocationData),
]);

Stream<dynamic> _startListening(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions.where((action) => action is StartListeningForLocation).switchMap((action) {
    Location location = new Location();

    location.serviceEnabled().then((bool _serviceEnabled) {
      if (!_serviceEnabled) {
        location.requestService().then((bool _serviceEnabled) {
          if (_serviceEnabled) {
            location.hasPermission().then((PermissionStatus _permissionGranted) {
              if (_permissionGranted == PermissionStatus.denied) {
                location.requestPermission();
              }
            });
          }
        });
      } else {
        location.hasPermission().then((PermissionStatus _permissionGranted) {
          if (_permissionGranted == PermissionStatus.denied) {
            location.requestPermission();
          }
        });
      }
    });
    return location.onLocationChanged.map((event) {
      print('location ${event}');
      return event;
    });
  });
}

Stream<dynamic> _processLocationData(Stream<dynamic> actions, EpicStore<AppState> store) {

  return actions.where((action) => action is LocationData).map((action) => checkLocations(store, action)).where((e) {
    return e.length > 0;
  }).map((event) => event[0]);
}

List<LocationAction> checkLocations(EpicStore<AppState> store, LocationData _position) {
  List<LocationAction> matchingActions = [];
  int runId = store.state.currentRunState.run?.runId ?? -1;
  if (runId == -1) {
    return matchingActions;
  }
  gameMinusActionLocationTriggers(store.state).forEach((point) {
    if (_position.latitude != null && _position.latitude != null && _position.accuracy != null) {
      print ('distance is ${GpsUtils.distance(point.lat, point.lng, _position.latitude!, _position.longitude!, 1)} --${_position.accuracy} ${(point.radius - _position.accuracy!)}');
      if (GpsUtils.distance(point.lat, point.lng, _position.latitude!, _position.longitude!, 1) <
          (point.radius - _position.accuracy!)) {
        print ('found and adding');
        matchingActions.add(LocationAction(lat: point.lat, lng: point.lng, radius: point.radius, runId: runId));
        //widget.onLocationFound(point.lat, point.lng, point.radius);
      }
    }
  });
  return matchingActions;
}
