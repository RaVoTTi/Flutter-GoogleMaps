import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_maps/bloc/map/map_bloc.dart';
import 'package:flutter_google_maps/bloc/my_ubication/my_ubication_bloc.dart';
import 'package:flutter_google_maps/pages/access_gps_page.dart';
import 'package:flutter_google_maps/pages/loading_page.dart';
import 'package:flutter_google_maps/pages/map_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ( _ ) => MyUbicationBloc(),),
        BlocProvider(create: ( _ ) => MapBloc(),)
        
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Material App Bar'),
          ),
          body: Center(
            child: Container(
              child: Text('Hello World'),
            ),
          ),
        ),
        initialRoute: 'loading',
        routes: {
          'map': (_) => MapPage(),
          'loading': (_) => LoadingPage(),
          'access_gps': (_) => AccessGpsPage(),
        },
      ),
    );
  }
}
