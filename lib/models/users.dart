import 'package:latlong2/latlong.dart';

class Users {
  String firstName;
  String lastName;
  String address;
  double lat;
  double lng;
  double? distance;

  String get displayName => "$firstName $lastName";
  LatLng get latLng => LatLng(lat, lng);

  Users({
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.lat,
    required this.lng,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        firstName: json["firstName"],
        lastName: json["lastName"],
        address: json["address"]["address"],
        lat: json["address"]["coordinates"]["lat"],
        lng: json["address"]["coordinates"]["lng"],
      );
}
