import 'dart:convert';
import 'package:google_places_flutter/model/place_details.dart';
import 'package:http/http.dart' as http;
import 'package:zappy/Pages/LocationSearchScreen/PlacePrediction.dart';

class PlacesService {
  static const String _apiKey = 'AIzaSyCejrgwc8YOfUgiyIav3acGZHifa1MY9wE';
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  static const String _autocompleteUrl =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  static const String _placeDetailsUrl =
      'https://maps.googleapis.com/maps/api/place/details/json';

  Future<List<PlacePrediction>> getPlacePredictions(String input) async {
    if (input.isEmpty) return [];

    final url =
        Uri.parse('$_baseUrl?input=$input&components=country:in&key=$_apiKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final predictions = (json['predictions'] as List)
            .map((prediction) => PlacePrediction.fromJson(prediction))
            .toList();
        return predictions;
      }
    } catch (e) {
      print('Error fetching place predictions: $e');
    }

    return [];
  }

  Future<Map<String, String>> getPlaceDetails(String placeId) async {
    final url = Uri.parse(
        '$_placeDetailsUrl?place_id=$placeId&fields=place_id,formatted_address,geometry&key=$_apiKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['status'] == 'OK') {
          return {
            "lat": json['result']['geometry']['location']['lat'].toString(),
            "lng": json['result']['geometry']['location']['lng'].toString(),
          };
        }
      }
    } catch (e) {
      print('Error fetching place details: $e');
    }

    return {};
  }
}
