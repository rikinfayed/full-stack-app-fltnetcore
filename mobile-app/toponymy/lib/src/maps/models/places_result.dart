import 'place.dart';

class PlacesResult {
  List<Place>? places;
  Place? place;
  String? message;
  String? messageError;

  PlacesResult({this.places, this.place, this.message, this.messageError});
}