import 'package:flutter/material.dart';
import 'package:flutter_google_maps/helpers/helpers.dart';
import 'package:flutter_google_maps/pages/access_gps_page.dart';
import 'package:flutter_google_maps/pages/map_page.dart';
import 'package:geolocator/geolocator.dart' as Geolocator;
import 'package:permission_handler/permission_handler.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {

  // LOS SIGUIENTES 3 OVERRIDES SON EPICOS
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);// registra cualquier cambio de estado
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    // imprime el estado de vida de la app
    if (state == AppLifecycleState.resumed) {
      if (await Geolocator.GeolocatorPlatform.instance.isLocationServiceEnabled()){ // si permitio el acceso al gps
        Navigator.pushReplacementNamed(context, 'map');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: this.checkGpsYLocation(context),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == 'Activar GPS'){
              return AlertDialog(
                title: Text('Debe activar el GPS'),);
              
            }
            return CircularProgressIndicator(
              strokeWidth: 2,
            );
          },
        ),
      ),
    );
  }

  Future checkGpsYLocation(BuildContext context) async {
    final permitionGPS = await Permission.location.isGranted;
    final activeGPS =
        await Geolocator.GeolocatorPlatform.instance.isLocationServiceEnabled();
    print(activeGPS);


    if (permitionGPS && activeGPS) {
      Navigator.pushReplacement(context, navigateMapFadeIn(context, MapPage()));
    } else if (!permitionGPS) {
      Navigator.pushReplacement(
          context, navigateMapFadeIn(context, AccessGpsPage()));
    } else if (!activeGPS) {
      return 'Activar GPS';
    }
    await Future.delayed(Duration(milliseconds: 500));
    // await Future.delayed(Duration(milliseconds: 5000));
  }
}
