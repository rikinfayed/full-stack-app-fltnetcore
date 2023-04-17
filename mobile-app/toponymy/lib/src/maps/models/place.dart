import 'dart:core';
import 'package:intl/intl.dart';

class Place {
  late int? id;
  late String nameOwner;
  late String place;
  late String address;
  late String type;
  late DateTime date;
  late double latitude;
  late double longitude;

  Place({
    this.id, 
    required this.nameOwner,
    required this.place,
    required this.address,
    required this.type,
    required this.date,
    required this.latitude,
    required this.longitude
  });

  Place.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameOwner = json['nameOwner'];
    place = json['place'];
    address = json['address'];
    type = json['type'];
    date = DateTime.parse(json['date']);
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = new Map<String, dynamic>();
    json['nameOwner'] = nameOwner;
    json['place'] = place;
    json['address'] = address;
    json['type'] = type;
    json['date'] = dateFormat.format(date);
    json['latitude'] = latitude;
    json['longitude'] = longitude;

    return json;
  }
}

DateFormat dateFormat = DateFormat('yyyy-MM-dd');