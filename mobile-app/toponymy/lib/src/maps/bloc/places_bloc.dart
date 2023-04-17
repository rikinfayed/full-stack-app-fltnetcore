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
    on<StorePlace>(_onStorePlace);
  }

  Map<String, Marker> markers = {};
  
  LatLng initialPosition =
      LatLng(-6.211679831657398, 106.84641695511087);

  Future<void> _onLoadPlaces(
      LoadPlaces event, Emitter<PlacesState> emit) async {
    try {
      PlacesResult placeResult = await PlacesService.places();

      if (kDebugMode) {
        print(placeResult.places?.length);
      }

      markers.clear();
      placeResult.places?.forEach((place) {
        final marker = Marker(
            markerId: MarkerId(place.id.toString()),
            position: LatLng(place.latitude, place.longitude),
            infoWindow: InfoWindow(title: place.place, snippet: place.address));
        markers[place.id.toString()] = marker;
      });
      emit(PlacesLoaded(placeResult.places ?? [], markers, initialPosition));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _onStorePlace(StorePlace event, Emitter<PlacesState> emit) async {
    try {
      

      PlacesResult placeResult = await PlacesService.placesStore(event.place);

      if(placeResult != null ) {
        Place? place = placeResult.place;

        final marker = Marker(
            markerId: MarkerId(place!.id.toString()),
            position: LatLng(place.latitude, place.longitude),
            infoWindow: InfoWindow(title: place.place, snippet: place.address));

        markers[place.place] = marker;

        initialPosition = LatLng(place.latitude, place.longitude);


        emit(PlacesLoaded(placeResult.places ?? [], markers, initialPosition));
      }

      if (kDebugMode) {
        print(placeResult.place);
      }

    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
