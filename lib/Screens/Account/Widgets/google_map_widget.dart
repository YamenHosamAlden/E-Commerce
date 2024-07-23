import 'package:ecommerce/Bloc/map_bloc/map_bloc.dart';
import 'package:ecommerce/Widgets/loading_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/gestures.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

class GoogleMapWidget extends StatefulWidget {
  final Function(
      {LatLng? latLng,
      String? street,
      String? subLocality,
      String? country,
      String? subAdministrativeArea,
      String? postalCode}) selectAddress;
  const GoogleMapWidget({super.key, required this.selectAddress});

  @override
  State<GoogleMapWidget> createState() => GoogleMapWidgetState();
}

class GoogleMapWidgetState extends State<GoogleMapWidget> {
  MapBloc mapBloc = MapBloc();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          mapBloc..add(InitMapEvent(selectAddress: widget.selectAddress)),
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: 3.w, ),
        height: 50.h,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(3.w),
                bottomLeft: Radius.circular(3.w))),
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            if (state is GetLocationLoadingState || state is MapInitial) {
              return const LoadingWidget();
            }
            return GoogleMap(
              mapType: MapType.hybrid,
              myLocationEnabled: true,
              initialCameraPosition: mapBloc.currentCameraPosition!,
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer(),
                ),
              },
              onMapCreated: (GoogleMapController controller) {
                mapBloc.googleMapController.complete(controller);
              },
              onTap: (latLng) {
                mapBloc.add(AddLocation(
                    selectedLocation: latLng,
                    selectAddress: widget.selectAddress));
              },
              markers: mapBloc.selectedLocation == null
                  ? {}
                  : {
                      Marker(
                        markerId: MarkerId('selected_location'),
                        position: mapBloc.selectedLocation!,
                      ),
                    },
            );
          },
        ),
      ),
    );
  }
}
