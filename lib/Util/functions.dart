// import 'package:ecommerce/Core/Constants/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';

// import 'package:url_launcher/url_launcher.dart';

// Future<void> launch(Uri url) async {
//   await canLaunchUrl(url)
//       ? await launchUrl(url, mode: LaunchMode.externalApplication)
//       : Fluttertoast.showToast(
//           msg: "Could Not Launch ",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIosWeb: 3,
//           backgroundColor: AppColors.redColor,
//           textColor: Colors.white,
//           fontSize: 16.0);
// }

// Future<String> getCountry() async {
//   try {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.low);
//     List<Placemark> placemarks =
//         await placemarkFromCoordinates(position.latitude, position.longitude);
//     return placemarks[0].isoCountryCode!;
//   } catch (e) {
//     return 'Error getting country $e';
//   }
// }
