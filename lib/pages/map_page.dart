import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_google_maps/bloc/map/map_bloc.dart';
import 'package:flutter_google_maps/bloc/my_ubication/my_ubication_bloc.dart';
import 'package:flutter_google_maps/widgets/widgets.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    BlocProvider.of<MyUbicationBloc>(context).getPosition();
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<MyUbicationBloc>(context).canceledPosition();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Stack(children: <Widget>[
      Container(
        width: width,
        height: height,
        color: Colors.white,
      ),
      BlocBuilder<MyUbicationBloc, MyUbicationState>(
          builder: (context, state) => Center(child: _createMap(state))),
    ]);
  }

  Widget _createMap(MyUbicationState state) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    mapBloc.add(OnLocationUpdate(state.ubication));
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    BorderRadiusGeometry borderRadius = BorderRadius.all(Radius.circular(30));
    if (!state.isUbication)
      return CircularProgressIndicator(
        strokeWidth: 2,
      );
    final cameraPosition = CameraPosition(target: state.ubication, zoom: 15);

    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: height * 0.8,
          width: width,
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
              // shape: BoxShape.circle,
              color: Colors.green,
              borderRadius: borderRadius),
          child: GoogleMap(
            padding: EdgeInsets.all(1),
            initialCameraPosition: cameraPosition,
            zoomControlsEnabled: false,
            buildingsEnabled: false,
            onMapCreated: mapBloc.initMap,
            // polylines: ,
            // (GoogleMapController controller) {
            //   bloc.initMap(controller);

            // },
            polylines: mapBloc.state.polylines.values.toSet(),
          ),
        ));
  }
}
