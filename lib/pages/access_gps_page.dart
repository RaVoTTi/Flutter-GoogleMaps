



import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AccessGpsPage extends StatefulWidget {
  // como StatefulWidget podes ver el context en toda la clase
  // si esta en el state los cambios no se aplican hasta hot restart
  @override
  _AccessGpsPageState createState() => _AccessGpsPageState();
}

class _AccessGpsPageState extends State<AccessGpsPage> with WidgetsBindingObserver{


  // LOS SIGUIENTES 3 OVERRIDES SON EPICOS
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
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
      if (await Permission.location.isGranted){ // si permitio el acceso al gps
        Navigator.pushReplacementNamed(context, 'map');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              color: Colors.black54,
              child: Text('Solicitar Acceso', style: TextStyle(color: Colors.white),),
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              onPressed: () async {
                // con el async y el await resolves un Future
                final status  = await Permission.location.request();
                this.accessGPS(status);
                },),
            Container(
              child: Text('Access_gps'),
            ),
          ],
        ),
      ),
    );
  }

  void accessGPS (PermissionStatus status) async{
    switch (status){
      

      case PermissionStatus.granted:
        Navigator.pushReplacementNamed(context, 'map');
        break;
      case PermissionStatus.restricted:
      case PermissionStatus.denied:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.limited:
        openAppSettings();
        break;
    }
  }
}
