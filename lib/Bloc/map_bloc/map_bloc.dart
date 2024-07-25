import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:geocoding/geocoding.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  String? street;
  String? subLocality;
  String? subAdministrativeArea;
  String? postalCode;
  String? country;
  Position? currentPosition;
  LatLng? selectedLocation;
  List<Placemark>? placemarks;

  String? errorMessage;
  CameraPosition? currentCameraPosition;
  Set<Marker> markers = const <Marker>{};
  final Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();


      

  Future<void> getAddressFromLatLng({required LatLng latLng}) async {
    await placemarkFromCoordinates(latLng.latitude, latLng.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];

      street = '${place.street}';
      subLocality = ' ${place.subLocality}';
      subAdministrativeArea = '${place.subAdministrativeArea}';
      postalCode = '${place.postalCode}';
      country = '${place.country}';
    }).catchError((e) {
      errorMessage = e.toString();
    });
  }

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      currentPosition = position;

      currentCameraPosition = CameraPosition(
          bearing: 0.0,
          target: LatLng(currentPosition!.latitude, currentPosition!.longitude),
          tilt: 0.0,
          zoom: 19.151926040649414);
    }).catchError((e) {
      errorMessage = e.toString();
    });
  }

  MapBloc() : super(MapInitial()) {
    on<InitMapEvent>((event, emit) async {
      emit(GetLocationLoadingState());
      await handleLocationPermission();
      await getCurrentPosition();
      await getAddressFromLatLng(
          latLng:
              LatLng(currentPosition!.latitude, currentPosition!.longitude));

      event.selectAddress(
          latLng: LatLng(currentPosition!.latitude, currentPosition!.longitude),
          postalCode: postalCode,
          subLocality: subLocality,
          country: country,
          subAdministrativeArea: subAdministrativeArea,
          street: street);

      emit(GetLocationSuccessfulState());
    });

    on<AddLocation>((event, emit) async {
      selectedLocation = event.selectedLocation;

      await getAddressFromLatLng(latLng: selectedLocation!);

      event.selectAddress(
          latLng: selectedLocation,
          postalCode: postalCode,
          subLocality: subLocality,
          country: country,
          subAdministrativeArea: subAdministrativeArea,
          street: street);

      emit(GetLocationSuccessfulState());
    });
  }
}
