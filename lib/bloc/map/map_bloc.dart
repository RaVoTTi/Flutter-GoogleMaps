import 'dart:async';
// import 'dart:convert';


import 'package:bloc/bloc.dart';
import 'package:flutter_google_maps/bloc/my_ubication/my_ubication_bloc.dart';
// import 'package:flutter_google_maps/theme/avocado_theme.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState());

  GoogleMapController _mapController;

  Polyline _myRoute = new Polyline(
    polylineId: PolylineId('myRoute'),
    width: 3
    );

  void initMap (GoogleMapController controller){

    if (!state.mapReady){
      this._mapController = controller;

      // PARA CAMBIAR EL TEMA
      // this._mapController.setMapStyle(jsonEncode(avocadoMapTheme));

      add(OnMapLoaded());
    }
  }

  void moveCamera (LatLng destination){
    // final cameraUpdate = CameraUpdate.newLatLng(destination);
    final cameraUpdate = CameraUpdate.newCameraPosition(CameraPosition(
      target: destination,
      zoom: 15));
    this._mapController?.animateCamera(cameraUpdate);



  }

  @override
  Stream<MapState> mapEventToState(MapEvent event,) async* {
    
    if (event is OnMapLoaded){

      yield state.copyWith(mapReady: true);
    }
    else if (event is OnLocationUpdate){
      
      print('Nueva ubicacion:  ${event.ubication}');
      List<LatLng> points = [...this._myRoute.points, event.ubication];
      this._myRoute = this._myRoute.copyWith(pointsParam: points);

      final currentPolylines = state.polylines;
      currentPolylines['myRoute'] = this._myRoute;
      
      yield state.copyWith(polylines: currentPolylines);
    }
    

  }
}
