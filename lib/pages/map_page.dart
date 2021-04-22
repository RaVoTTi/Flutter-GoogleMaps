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
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final _width = MediaQuery.of(context).size.width;
    final _toolBarHeight = _height * 0.07;
    final searcherCtrl = TextEditingController();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: _toolBarHeight,
          // TextTitle(text1: 'MAPA', text2: ('Malargüe').toUpperCase(),)),

          actions: [
            _burgerMenu(_width)
          ],
        ),
        body: BlocBuilder<MyUbicationBloc, MyUbicationState>(
            builder: (context, state) => Center(child: _titleMap(state))),

        floatingActionButton: _twoButtons(),
        endDrawer: SideBar(),
        // bottomSheet: Searcher(placeHolder: 'Donde quiere ir?', textController: searcherCtrl),
      ),
    );
  }

  Widget _titleMap(MyUbicationState state) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final _sizeBox = _height * 0.025;

    mapBloc.add(OnLocationUpdate(state.ubication));

    if (!state.isUbication)
      return CircularProgressIndicator(
        strokeWidth: 2,
      );

    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextTitle(text1: 'CUYO', text2: 'BUS'),
          SizedBox(
            height: _sizeBox,
          ),
          _createMap(state, mapBloc, _height)
        ],
      ),
    );
  }

  Widget _twoButtons() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          BtnUbication(),
          SizedBox(
            height: 3,
          ),
          BtnBus(),
          // SizedBox(height: 30,),
          // SizedBox(height: 3,),
          // Searcher(placeHolder: 'Donde quiere ir?', textController: searcherCtrl)
        ],
      ),
    );
  }

  Widget _createMap(MyUbicationState state, MapBloc mapBloc, double height) {
    final cameraPosition = CameraPosition(target: state.ubication, zoom: 15);

    BorderRadiusGeometry _borderRadius = BorderRadius.only(
        topRight: Radius.circular(70), topLeft: Radius.circular(70));

    final _toolBarHeight = height * 0.07;
    final _mapHeight = (height * 0.82);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: _borderRadius,
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 5)
        ],
      ),
      height: (_mapHeight),
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
    );
  }
}
Widget _burgerMenu(double _width){
  return Padding(
              padding: EdgeInsets.symmetric(horizontal: _width * 0.038),
              child: Builder(
                  builder: (BuildContext context) => IconButton(
                      icon: const Icon(
                        Icons.menu,
                        size: 40,
                      ),
                      onPressed: () => Scaffold.of(context).openEndDrawer())),
            );
}
