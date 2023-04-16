part of 'places_bloc.dart';

@immutable
abstract class PlacesState extends Equatable{}

class PlacesInitial extends PlacesState {
  @override
  List<Object> get props => [];
}

class PlacesLoading extends PlacesState {
  @override
  List<Object> get props => [];
}

class PlacesLoaded extends PlacesState {
  List<Place> places;
  Map<String, Marker> markers = {};

  PlacesLoaded(this.places, this.markers);

  @override
  List<Object> get props => [this.places, this.markers];
}