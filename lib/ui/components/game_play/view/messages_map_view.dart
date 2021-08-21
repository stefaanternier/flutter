import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:youplay/models/game.dart';
import 'package:youplay/models/general_item.dart';

class MessagesMapView extends StatefulWidget {
  List<ItemTimes> items = [];
  Function(GeneralItem) tapEntry;
  Game? game;

  MessagesMapView({this.game, required this.items, required this.tapEntry})
      : _kInitialPosition = CameraPosition(
          target: (game == null || game.lat == null || game.lng == null)
              ? LatLng(50.886959, 5.973426)
              : LatLng(game.lat!, game.lng!),
          zoom: 14.0,
        );

  CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(50.886959, 5.973426),
    zoom: 14.0,
  );

  @override
  _MessagesMapViewState createState() => _MessagesMapViewState();
}

class _MessagesMapViewState extends State<MessagesMapView> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

  void initLoc(GoogleMapController controller) async {
    bool _serviceEnabled;
    Location location = new Location();
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    LocationData locationData = await location.getLocation();
    if (locationData.latitude != null &&
        locationData.longitude != null) {
      controller.animateCamera(CameraUpdate.newLatLngZoom(
          LatLng(locationData.latitude!, locationData.longitude!), 16));
    }
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> _markers = widget.items
        .where((element) => element.generalItem.showOnMap)
        .where((element) => element.generalItem.lat != null)
        .map((item) => Marker(
              markerId: MarkerId("${item.generalItem.itemId}"),
              position:
                  LatLng(item.generalItem.lat ?? 50, item.generalItem.lng ?? 6),
              infoWindow: InfoWindow(
                  title: "${item.generalItem.title}",
                  onTap: () => widget.tapEntry(item.generalItem)),
              onTap: () {},
            ))
        .toSet();
    return GoogleMap(
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
        Factory<OneSequenceGestureRecognizer>(
          () => EagerGestureRecognizer(),
        ),
      ].toSet(),
      mapType: MapType.normal,
      markers: _markers,
      initialCameraPosition: widget._kInitialPosition,
      myLocationEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
        initLoc(controller);
      },
    );
  }
}
