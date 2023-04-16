part of 'places_bloc.dart';

@immutable
abstract class PlacesEvent extends Equatable{}

class LoadPlaces extends PlacesEvent {
  @override
  List<Object> get props => [];
}