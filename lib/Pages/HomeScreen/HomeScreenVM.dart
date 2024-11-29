import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zappy/Helpers/AppNavigations/NavigationConfig.dart';
import 'package:zappy/Helpers/AppNavigations/NavigationMixin.dart';
import 'package:zappy/Helpers/Utilities/Utilities.dart';
import 'package:zappy/Pages/HomeScreen/HomeScreenModel.dart';

class HomeScreenVM extends HomeScreenModel {
  void navigateToSearchScreen() {
    try {
      addNavigationToStream(
          navigate: NavigatorPush(
              pageConfig: Pages.locationSearchScreenConfig,
              data: [
            scourceLocation,
            destinationLocation,
            updateSourceLocation,
            updateDestinationLocation
          ]));
    } catch (error) {
      error.logExceptionData();
    }
  }

  void updateSourceLocation(LatLng source) {
    try {
      setSourceLocation(source);
    } catch (error) {
      error.logExceptionData();
    }
  }

  void updateDestinationLocation(LatLng destination) {
    try {
      setDestinationLocation(destination);
    } catch (error) {
      error.logExceptionData();
    }
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PointLatLng origin =
        PointLatLng(scourceLocation.latitude, scourceLocation.longitude);
    PointLatLng destination = PointLatLng(
        destinationLocation.latitude, destinationLocation.longitude);

    PolylineRequest request = PolylineRequest(
      origin: origin,
      destination: destination,
      mode: TravelMode.driving,
    );
    if (destination.latitude == 0.0) {
      return;
    }
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: "AIzaSyCejrgwc8YOfUgiyIav3acGZHifa1MY9wE",
        request: request);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polypoints.add(LatLng(point.latitude, point.longitude)));
    }
  }
}
