import 'dart:core';
import 'package:intl/intl.dart';

class Place {
  late int id;
  late String nameOwner;
  late String place;
  late String address;
  late String type;
  late DateTime date;
  late double latitude;
  late double longitude;

  Place(
    this.id, 
    this.nameOwner,
    this.place,
    this.address,
    this.type,
    this.date,
    this.latitude,
    this.longitude
  );

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
}

class TypePlace{
  static const String school = "scholl";
  static const String office = "office";
}

DateFormat dateFormat = DateFormat('dd-MM-yyyy');