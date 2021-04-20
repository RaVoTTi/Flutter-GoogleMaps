import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart' as Geolocator;
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:meta/meta.dart';

part 'my_ubication_event.dart';
part 'my_ubication_state.dart';

class MyUbicationBloc extends Bloc<MyUbicationEvent, MyUbicationState> {
  MyUbicationBloc() : super(MyUbicationState());
  final _geolocator = Geolocator.GeolocatorPlatform.instance;

  StreamSubscription<Geolocator.Position> _positionSuscription;

  void getPosition() {
    _geolocator
        .getPositionStream(
            desiredAccuracy: Geolocator.LocationAccuracy.high,
            distanceFilter: 10,
            )
        .listen((Geolocator.Position position) {


      add(OnUbicationChange(LatLng(position.latitude, position.longitude)));
    });
  }
  void canceledPosition(){
    this._positionSuscription?.cancel();
  }

  @override
  Stream<MyUbicationState> mapEventToState(MyUbicationEvent event,) async* {
    if (event is OnUbicationChange){
      // print(event);
      yield state.copyWith(
        isUbication: true,
        ubication: event.ubication
      );


    }
  }
}
