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


    return SafeArea(
      child: Stack(children: <Widget>[
        Container(
            width: width,
            height: height,
            color: Colors.white,
         
        ),
        Align(
          alignment: Alignment(0.9,-0.95),
          child:GestureDetector(
                  onTap: () {
                    print('PUTOOOOO');
                  },
                  child: Icon(Icons.menu, color: Color(0xff00939d), size: height * 0.04),),
                ),
            
        Align(
          alignment: Alignment(0, -0.86),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextTitle(text: 'MAPA'),
              TextTitle(
                text: ('Malargüe').toUpperCase(),
                bold: true,
              )
            ],
          ),
        ),
        BlocBuilder<MyUbicationBloc, MyUbicationState>(
            builder: (context, state) => Center(child: _createMap(state))),
      ]),
    );
  }

  Widget _createMap(MyUbicationState state) {

    var height = MediaQuery.of(context).size.height;
    final _mapHeight =  height * 0.82; 



    final mapBloc = BlocProvider.of<MapBloc>(context);
    mapBloc.add(OnLocationUpdate(state.ubication));
    BorderRadiusGeometry _borderRadius = BorderRadius.only(
        topRight: Radius.circular(70), topLeft: Radius.circular(70));
    if (!state.isUbication)
      return CircularProgressIndicator(
        strokeWidth: 2,
      );
    final cameraPosition = CameraPosition(target: state.ubication, zoom: 15);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: _borderRadius,
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 5)
          ],
        ),
        height: _mapHeight,
        child: ClipRRect(
          borderRadius: _borderRadius,
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
        ),
      ),
    );
  }
}
