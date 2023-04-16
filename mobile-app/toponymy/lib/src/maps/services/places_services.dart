import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:toponymy/src/network/network.dart';

import '../models/models.dart';

class PlacesService {
  static ProviderNetwork provider = ProviderNetwork();

  static Future<PlacesResult> getPlaces() async {
    try {

      String response = await provider.get("Api/Places");

      List<dynamic> jsonArray = json.decoder.convert(response);

      // jsonArray.forEach((i) => print(i["id"]));

      List<Place> places = jsonArray.map((dynamic json) => Place.fromJson(json)).toList();

      // print("index static : ${jsonArray[0]}");

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
}