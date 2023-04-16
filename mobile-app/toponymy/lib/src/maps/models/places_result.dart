import 'place.dart';

class PlacesResult {
  List<Place>? places;
  String? message;
  String? messageError;

  PlacesResult({this.places, this.message, this.messageError});
}