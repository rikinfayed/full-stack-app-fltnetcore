import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../services/places_services.dart';
import '../models/models.dart';

part 'places_event.dart';
part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  PlacesBloc() : super(PlacesInitial()) {
    on<LoadPlaces>(_onLoadPlaces);
  }

  Map<String, Marker> markers = {};

  Future<void> _onLoadPlaces(
      LoadPlaces event, Emitter<PlacesState> emit) async {
    try {
      PlacesResult placeResult = await PlacesService.getPlaces();

      if (kDebugMode) {
        print(placeResult.places?.length);
      }

      markers.clear();
      placeResult.places?.forEach((place) {
        final marker = Marker(
            markerId: MarkerId(place.id.toString()),
            position: LatLng(place.latitude, place.longitude),
            infoWindow: InfoWindow(title: place.place, snippet: place.address));
        markers[place.place] = marker;
      });
      emit(PlacesLoaded(placeResult.places ?? [], markers));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
