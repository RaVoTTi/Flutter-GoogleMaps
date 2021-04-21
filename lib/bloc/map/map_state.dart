part of 'map_bloc.dart';

@immutable
class MapState {
  final bool mapReady;
  final bool drawRoute;

  // Polylines
  final Map<String, Polyline> polylines;
  // final Map<String, Polyline> polylines ={
  //   'mi_ruta': {
  //     id: 'id1',
  //     points: [[12,32],[23,43],[21,12]],
  //     color: black,
  //     width: 3
  //   }
  // };


  MapState({
    this.drawRoute = false,
    this.mapReady = false,
    Map<String, Polyline> polylines,
  }) : polylines = polylines ?? Map();

  MapState copyWith({
    bool mapReady, 
    bool drawRoute,
    Map<String, Polyline> polylines
  }) => MapState(
    mapReady: mapReady ?? this.mapReady,
    drawRoute: drawRoute ?? this.drawRoute,
    polylines: polylines ?? this.polylines);
}
