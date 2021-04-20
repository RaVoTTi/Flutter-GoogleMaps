part of 'my_ubication_bloc.dart';

@immutable
class MyUbicationState {
// todas las variables deben ser final
  final bool follow;
  final bool isUbication;
  final LatLng ubication;

  MyUbicationState({
    this.follow = true,
    this.isUbication = false,
    this.ubication = const LatLng( 21, 32)});


MyUbicationState copyWith ({
  bool follow,
  bool isUbication,
  LatLng ubication,
}) => MyUbicationState(
follow      : follow      ?? this.follow,
isUbication : isUbication ?? this.isUbication,
ubication   : ubication   ?? this.ubication,
);
}
class MyUbicationInitial extends MyUbicationState {}
