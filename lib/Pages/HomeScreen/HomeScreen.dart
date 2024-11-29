import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zappy/Helpers/AppConstants/AppConstants.dart';
import 'package:zappy/Helpers/AppNavigations/NavigationHelpers.dart';
import 'package:zappy/Helpers/AppNavigations/NavigationMixin.dart';
import 'package:zappy/Helpers/Resources/Styles/Styles.dart';
import 'package:zappy/Helpers/ResponsiveUI.dart';
import 'package:zappy/Pages/HomeScreen/HomeScreenVM.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LatLng scourceLocation = const LatLng(12.934594, 79.136642);
  final LatLng destinationLocation = const LatLng(12.857184, 79.122273);
  List<LatLng> polyPoints = [];
  GoogleMapController? mapController;

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  HomeScreenVM _homeScreenVM = HomeScreenVM();

  void setCustomMarker() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, AppConstants.sourceIcon)
        .then((icon) {
      sourceIcon = icon;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, AppConstants.destinationIcon)
        .then((icon) {
      destinationIcon = icon;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController?.setMapStyle(AppConstants.mapStyle);
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
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: "AIzaSyCejrgwc8YOfUgiyIav3acGZHifa1MY9wE",
        request: request);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polyPoints.add(LatLng(point.latitude, point.longitude)));
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setCustomMarker();
    // _homeScreenVM.getPolyPoints();
    // getPolyPoints();
    _homeScreenVM.navigationStream.stream.listen((event) {
      if (event is NavigatorPush) {
        context.push(pageConfig: event.pageConfig, data: event.data);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_homeScreenVM.destinationLocation.latitude);
    if (_homeScreenVM.destinationLocation.latitude != 0.0) {
      _homeScreenVM.getPolyPoints();
    }
    _homeScreenVM.getPolyPoints();
    setState(() {});
    return Observer(builder: (context) {
      return Scaffold(
        appBar: null,
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _homeScreenVM.scourceLocation,
                zoom: 13.5,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('source'),
                  position: _homeScreenVM.scourceLocation,
                  icon: sourceIcon,
                  infoWindow: const InfoWindow(title: 'Source'),
                ),
                Marker(
                  markerId: const MarkerId('destination'),
                  position: _homeScreenVM.destinationLocation,
                  icon: destinationIcon,
                  infoWindow: const InfoWindow(title: 'Destination'),
                )
              },
              polylines: {
                Polyline(
                  polylineId: const PolylineId("route"),
                  points: _homeScreenVM.polypoints,
                  color: Styles.primaryColor,
                  width: 3,
                )
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
            ),

            // Rest of your UI components remain the same
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveUI.w(16, context),
                    vertical: ResponsiveUI.h(10, context),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        AppConstants.menuIcon,
                        width: ResponsiveUI.w(24, context),
                        height: ResponsiveUI.h(24, context),
                      ),
                      SvgPicture.asset(
                        AppConstants.profileIcon,
                        width: ResponsiveUI.w(24, context),
                        height: ResponsiveUI.h(24, context),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            DraggableScrollableSheet(
              initialChildSize: 0.4,
              minChildSize: 0.2,
              maxChildSize: 0.8,
              snap: true,
              snapSizes: [0.4, 0.8],
              builder: (context, scrollController) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveUI.w(16, context),
                  ),
                  decoration: BoxDecoration(
                    color: Styles.primaryColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(ResponsiveUI.r(20, context)),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: ListView(
                    padding: EdgeInsets.only(top: ResponsiveUI.h(12, context)),
                    controller: scrollController,
                    children: [
                      Center(
                        child: Container(
                          width: ResponsiveUI.w(60, context),
                          height: ResponsiveUI.h(10, context),
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            color: const Color(0xff72727263),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          focusColor: Styles.secondaryColor,
                          prefixIcon: SvgPicture.asset(
                            AppConstants.searchIcon,
                            width: ResponsiveUI.w(20, context),
                            height: ResponsiveUI.h(20, context),
                          ),
                          prefixIconConstraints: BoxConstraints(
                            minWidth: ResponsiveUI.w(55, context),
                            minHeight: ResponsiveUI.h(20, context),
                          ),
                          hintText: "Where are you going to?",
                          hintStyle: TextStyle(
                            color: Styles.textTertiary,
                            fontFamily: "MontserratRegular",
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Styles.backgroundPrimary,
                              width: ResponsiveUI.w(1, context),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Styles.backgroundPrimary,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(
                              ResponsiveUI.r(10, context),
                            ),
                          ),
                        ),
                      ),
                      // ),
                      SizedBox(height: ResponsiveUI.h(42, context)),
                      GestureDetector(
                        onTap: () {
                          _homeScreenVM.navigateToSearchScreen();
                        },
                        child: SvgPicture.asset(
                          AppConstants.appLogo,
                          width: ResponsiveUI.w(126, context),
                          height: ResponsiveUI.h(53, context),
                        ),
                      ),
                      SizedBox(height: ResponsiveUI.h(19, context)),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveUI.w(65, context),
                        ),
                        width: ResponsiveUI.w(272, context),
                        height: ResponsiveUI.h(60, context),
                        child: Text(
                          "Instant Bookings, Zappy Convenience.",
                          style: TextStyle(
                            fontFamily: "MontserratBold",
                            fontSize: ResponsiveUI.sp(20, context),
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            height: 30 / 25,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: ResponsiveUI.h(28, context)),
                      Container(
                        height: ResponsiveUI.h(40, context),
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveUI.w(100, context),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Made in India ${_homeScreenVM.scourceLocation}",
                              style: TextStyle(
                                fontFamily: "MontserratRegular",
                                fontSize: ResponsiveUI.sp(14, context),
                                fontWeight: FontWeight.w500,
                                color: Styles.backgroundPrimary,
                                height: 17 / 14,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              "Crafted by #Vellore ${_homeScreenVM.scourceLocation}",
                              style: TextStyle(
                                fontFamily: "MontserratRegular",
                                fontSize: ResponsiveUI.sp(14, context),
                                fontWeight: FontWeight.w500,
                                color: Styles.backgroundPrimary,
                                height: 17 / 14,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      );
    });
  }
}
