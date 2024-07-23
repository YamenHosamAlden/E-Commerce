part of 'map_bloc.dart';

@immutable
sealed class MapEvent {}

class InitMapEvent extends MapEvent {
  final Function(
      {
        LatLng? latLng,
        String? street,
      String? subLocality,
            String? country,

      String? subAdministrativeArea,
      String? postalCode}) selectAddress;

  InitMapEvent({required this.selectAddress});
}

class AddLocation extends MapEvent {
  final LatLng selectedLocation;
    final Function(
      { LatLng? latLng,String? street,
      String? subLocality,
      String? subAdministrativeArea,
      String? country,
      String? postalCode}) selectAddress;

  AddLocation({required this.selectedLocation,required this.selectAddress});
}
