
import 'dart:async';


import 'package:youplay/models/general_item.dart';
import 'package:youplay/screens/util/location/gps_utils.dart';
import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
//
//@visibleForTesting
//typedef Geolocator LocationFactory();
//
//@visibleForTesting
//void mockLocation(LocationFactory mock) {
//  _createLocation = mock;
//}
//
//LocationFactory _createLocation = () => Geolocator();
//
//class LocationContext extends InheritedWidget {
//  final Position currentLocation;
//  final Position lastLocation;
//  final String error;
//
//  LocationContext._({
//    @required this.currentLocation,
//    this.lastLocation,
//    this.error,
//    Key key,
//    Widget child,
//  }) : super(key: key, child: child);
//
//  static LocationContext of(BuildContext context) {
//    return context.inheritFromWidgetOfExactType(LocationContext);
//  }
//
//  static Widget around(Widget child, List<LocationTrigger> points, Function onLocFound, {Key key}) {
//    return _LocationContextWrapper(child: child,points:points,onLocationFound:onLocFound,key: key);
//  }
//
//  double distanceFrom(double lat, double lng) {
//    if (this.currentLocation == null) return null;
//    return GpsUtils.distance(lat, lng, currentLocation.latitude, currentLocation.longitude, 1);
//  }
//
//  @override
//  bool updateShouldNotify(LocationContext oldWidget) {
//    return currentLocation != oldWidget.currentLocation ||
//        lastLocation != oldWidget.lastLocation ||
//        error != oldWidget.error;
//  }
//}
//
//class _LocationContextWrapper extends StatefulWidget {
//  final Widget child;
//  final List<LocationTrigger> points;
//  Function onLocationFound;
//
//  _LocationContextWrapper({Key key, this.points, this.onLocationFound, this.child}) : super(key: key);
//
//  @override
//  State<StatefulWidget> createState() => _LocationContextWrapperState();
//}
//
//class _LocationContextWrapperState extends State<_LocationContextWrapper> {
//
//  final Geolocator _location = _createLocation();
//  LocationOptions locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 5);
//
//  String _error;
//
//  Position _currentLocation;
//  Position _lastLocation;
//
//  StreamSubscription<Position> _locationChangedSubscription;
//
//  @override
//  void initState() {
//    super.initState();
//
//    _locationChangedSubscription = _location.getPositionStream(locationOptions).listen(
//            (Position _position) {
//              setState(() {
//                _error = null;
//                _lastLocation = _currentLocation;
//                _currentLocation = _position;
//                dynamic removePoint;
//                widget.points.forEach((point){
//                  if (GpsUtils.distance(point.lat, point.lng, _position.latitude, _position.longitude, 1)< (point.radius-_position.accuracy)) {
//                    print("location found ${point.lat} ${point.lng}");
//                    widget.onLocationFound(point.lat, point.lng, point.radius);
//                    removePoint = point;
//                  } else {
//                    print ("distance is ${GpsUtils.distance(point.lat, point.lng, _position.latitude, _position.longitude, 1)}");
//                  }
//                });
//                if (removePoint!=null) widget.points.remove(removePoint);
//              });
//
//        });
//
//    initLocation();
//  }
//
//  void initLocation() async {
////    try {
//      final Position result = await _location.getLastKnownPosition();
//
//      setState(() {
//        _error = null;
//        _lastLocation = result;
//        _currentLocation = _lastLocation;
//      });
//      //todo check what happens if permission is denied
////    } on PlatformException catch (e) {
////      setState(() {
////        if (e.code == 'PERMISSION_DENIED') {
////          _error = 'Location Permission Denied';
////        } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
////          _error =
////          'Location Permission Denied. Please open App Settings and enabled Location Permissions';
////        }
////      });
////    }
//  }
//
//  @override
//  void dispose() {
//    _locationChangedSubscription?.cancel();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return LocationContext._(
//      lastLocation: _lastLocation,
//      currentLocation: _currentLocation,
//      error: _error,
//      child: widget.child,
//    );
//  }
//}
