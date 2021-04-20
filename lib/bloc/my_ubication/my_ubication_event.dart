part of 'my_ubication_bloc.dart';

@immutable
abstract class MyUbicationEvent {}

// events arrancan con On
class OnUbicationChange extends MyUbicationEvent{

  final LatLng ubication;

  OnUbicationChange(this.ubication);
}