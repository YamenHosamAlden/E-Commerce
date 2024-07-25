import 'dart:async';

import 'package:ecommerce/Widgets/loading_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:sizer/sizer.dart';

class MapOrderDetailsWidget extends StatefulWidget {
  const MapOrderDetailsWidget({super.key});

  @override
  State<MapOrderDetailsWidget> createState() => _MapOrderDetailsWidgetState();
}

class _MapOrderDetailsWidgetState extends State<MapOrderDetailsWidget> {
  CameraPosition? currentCameraPosition;
  Position? currentPosition;
  String? errorMessage;
  final Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();
  bool isLoading = false;

  Future<void> getCurrentPosition() async {
    setState(() {
      isLoading = true;
    });
    final hasPermission = await handleLocationPermission();
    if (!hasPermission) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        currentPosition = position;
        currentCameraPosition = CameraPosition(
          bearing: 0.0,
          target: LatLng(currentPosition!.latitude, currentPosition!.longitude),
          tilt: 0.0,
          zoom: 17.151926040649414,
        );
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
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


  @override
  void initState() {
    handleLocationPermission();
    getCurrentPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 3.w, ),
      height: 50.h,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(3.w),
              bottomLeft: Radius.circular(3.w))),
      child: isLoading
          ? const LoadingWidget()
          : GoogleMap(
              mapType: MapType.hybrid,
              myLocationEnabled: true,
              initialCameraPosition: currentCameraPosition!,
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer(),
                ),
              },
              onMapCreated: (GoogleMapController controller) {
                googleMapController.complete(controller);
              },

              // markers:
            ),
    );
  }
}
