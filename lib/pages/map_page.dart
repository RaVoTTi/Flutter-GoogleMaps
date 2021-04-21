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
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   toolbarHeight: 150,
      //   actions: [],
      // ),
      body: BlocBuilder<MyUbicationBloc, MyUbicationState>(
          builder: (context, state) => Center(child: _createMap(state))),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[BtnUbication()],
      ),
    );
  }

  Widget _createMap(MyUbicationState state) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    mapBloc.add(OnLocationUpdate(state.ubication));

    if (!state.isUbication)
      return CircularProgressIndicator(
        strokeWidth: 2,
      );
    final cameraPosition = CameraPosition(target: state.ubication, zoom: 15);
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: GoogleMap(
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
      ),
    );
  }
}
