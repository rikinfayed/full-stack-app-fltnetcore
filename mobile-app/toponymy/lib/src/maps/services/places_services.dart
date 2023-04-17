import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:toponymy/src/network/network.dart';

import '../models/models.dart';

class PlacesService {
  static ProviderNetwork provider = ProviderNetwork();

  static Future<PlacesResult> places() async {
    try {

      String response = await provider.get("Api/Places");

      List<dynamic> jsonArray = json.decoder.convert(response);

      List<Place> places = jsonArray.map((dynamic json) => Place.fromJson(json)).toList();

      if(kDebugMode) {
        print("PlaceService : ${response}");
      }

      return PlacesResult(places: places);
    } catch (e) {

      if(kDebugMode) {
        print(e);
      }

      return PlacesResult(messageError: e.toString());
    }
  }

  static Future<PlacesResult> placesStore(Place place) async {
    try {
      Map<String, dynamic> map = place.toJson();

      String response = await provider.post("Api/Places/Store", map);

      Map<String, dynamic> jsonObject = json.decoder.convert(response);

      if(kDebugMode) {
        print("PlaceService : ${map}");
      }

      return PlacesResult(place: Place.fromJson(jsonObject));
    } catch (e) {

      if(kDebugMode) {
        print(e);
      }

      return PlacesResult(messageError: e.toString());
    }
  }
}