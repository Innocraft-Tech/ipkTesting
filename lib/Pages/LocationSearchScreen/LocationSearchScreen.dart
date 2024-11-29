import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/place_details.dart';
import 'package:zappy/Helpers/AppNavigations/NavigationHelpers.dart';
import 'package:zappy/Helpers/AppNavigations/NavigationMixin.dart';
import 'package:zappy/Pages/LocationSearchScreen/AppColors.dart';
import 'package:zappy/Pages/LocationSearchScreen/DependentViews/CustomSearchBar.dart';
import 'package:zappy/Pages/LocationSearchScreen/DependentViews/LocationResultTile.dart';
import 'package:zappy/Pages/LocationSearchScreen/LocationSearchScreenVM.dart';
import 'package:zappy/Pages/LocationSearchScreen/PlacePrediction.dart';
import 'package:zappy/Services/GoogleMapService/PlaceServices.dart';

class LocationSearchScreen extends StatefulWidget {
  List locations;
  LocationSearchScreen({super.key, required this.locations});

  @override
  State<LocationSearchScreen> createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
  LocationSearchScreenVM _locationSearchScreenVM = LocationSearchScreenVM();
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _dropController = TextEditingController();
  final PlacesService _placesService = PlacesService();
  List<PlacePrediction> _predictions = [];
  bool _isLoading = false;
  bool _isPickupActive = true; // Track which search bar is active

  @override
  void dispose() {
    _pickupController.dispose();
    _dropController.dispose();
    super.dispose();
  }

  Future<void> _onSearchChanged(String query, bool isPickup) async {
    setState(() {
      _isPickupActive = isPickup;
      if (query.isEmpty) {
        _predictions = [];
        return;
      }
      _isLoading = true;
    });

    try {
      final predictions = await _placesService.getPlacePredictions(query);
      setState(() => _predictions = predictions);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _onLocationSelected(String location) async {
    String placeId = "";
    _predictions.forEach((place) {
      place.mainText == location.split(',')[0] ? placeId = place.placeId : null;
    });
    if (_isPickupActive) {
      _pickupController.text = location;
      Map<String, String> currentLocation =
          await _placesService.getPlaceDetails(placeId);
      widget.locations[0] = LatLng(double.parse(currentLocation["lat"]!),
          double.parse(currentLocation["lng"]!));
      widget.locations[2](LatLng(
          double.parse(currentLocation["lat"]!),
          double.parse(currentLocation[
              "lng"]!))); // Update the pickup location in the list
    } else {
      _dropController.text = location;
      Map<String, String> currentLocation =
          await _placesService.getPlaceDetails(placeId);
      widget.locations[1] = LatLng(double.parse(currentLocation["lat"]!),
          double.parse(currentLocation["lng"]!));
      widget.locations[3](
          LatLng(
          double.parse(currentLocation["lat"]!),
          double.parse(currentLocation[
              "lng"]!))); // Update the pickup location in the list
      _locationSearchScreenVM.navigateToHomeScreen();
    }
    setState(() => _predictions = []);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _locationSearchScreenVM.navigationStream.stream.listen((event) {
      if (event is NavigatorPop) {
        context.pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Back',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Search Bars
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  CustomSearchBar(
                    hint: 'Your Current Location',
                    dotColor: AppColors.primary,
                    controller: _pickupController,
                    onFocus: () => setState(() => _isPickupActive = true),
                    onChanged: (query) => _onSearchChanged(query, true),
                    onLocationSelected: _onLocationSelected,
                  ),
                  const SizedBox(height: 16),
                  CustomSearchBar(
                    hint: 'Search for a destination',
                    dotColor: Colors.orange,
                    controller: _dropController,
                    onFocus: () => setState(() => _isPickupActive = false),
                    onChanged: (query) => _onSearchChanged(query, false),
                    onLocationSelected: _onLocationSelected,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            if (_predictions.isNotEmpty) ...[
              // Search Results Header
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Search Results',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Results List
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        itemCount: _predictions.length,
                        separatorBuilder: (context, index) => Divider(
                          color: AppColors.divider,
                          height: 1,
                        ),
                        itemBuilder: (context, index) {
                          final prediction = _predictions[index];
                          return LocationResultTile(
                            index: _predictions.indexOf(prediction),
                            name: prediction.mainText,
                            address: prediction.secondaryText,
                            onTap: () {
                              final location =
                                  '${prediction.mainText}, ${prediction.secondaryText}';
                              _onLocationSelected(location);
                            },
                          );
                        },
                      ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
