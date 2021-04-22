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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    print(height);
    return SafeArea(
          child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: height * 0.07,
          // TextTitle(text1: 'MAPA', text2: ('Malargüe').toUpperCase(),)),

          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.038),
              child: Builder(
                  builder: (BuildContext context) => IconButton(
                      icon: const Icon(
                        Icons.menu,
                        size: 40,
                      ),
                      onPressed: () => Scaffold.of(context).openEndDrawer())),
            ),
          ],
        ),
        body: BlocBuilder<MyUbicationBloc, MyUbicationState>(
            builder: (context, state) => Center(child: _createMap(state))),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[BtnUbication()],
        ),
        endDrawer: Drawer(),
      ),
    );
  }

  Widget _createMap(MyUbicationState state) {
    final height = MediaQuery.of(context).size.height;
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final _mapHeight = height * 0.82;
    final _sizeBox  = height * 0.025;
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextTitle(text1: 'MAPA', text2: 'Malargüe'.toUpperCase()),
          SizedBox(height: _sizeBox,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: _borderRadius,
              boxShadow: <BoxShadow>[
                BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 5)
              ],
            ),
            height: _mapHeight,
            child: ClipRRect(
              borderRadius: _borderRadius,
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
          ),
        ],
      ),
    );
  }
}
