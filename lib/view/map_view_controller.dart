// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:basarsoft_task/models/get_user_data.dart';
import 'package:basarsoft_task/models/users.dart';
import 'package:basarsoft_task/view/map_view.dart';
import 'package:flutter/material.dart';
import 'dart:math' as Math;
import 'package:flutter_map/flutter_map.dart';

class MapViewController {
  List<Users> searchList = [];
  List<Marker> marker = <Marker>[];
  List<Users> destinationlist = <Users>[];
  double? selectedLat;
  double? selectedLng;

  void searchFunc() {
    user.forEach((user) {
      if (user.displayName.toLowerCase().trim().contains(controller.text) ||
          user.address
              .toString()
              .toLowerCase()
              .trim()
              .contains(controller.text)) {
        searchList.add(user);
      }
    });
  }

  double getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2) {
    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(lat2 - lat1); // deg2rad below
    var dLon = deg2rad(lon2 - lon1);
    var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(deg2rad(lat1)) *
            Math.cos(deg2rad(lat2)) *
            Math.sin(dLon / 2) *
            Math.sin(dLon / 2);
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    var d = R * c; // Distance in km
    return d;
  }

  double deg2rad(deg) {
    return deg * (Math.pi / 180);
  }

  distanceCalculation() {
    destinationlist = [];
    if (selectedLat != null && selectedLng != null) {
      for (var d in user) {
        var km =
            getDistanceFromLatLonInKm(selectedLat, selectedLng, d.lat, d.lng);
        d.distance = km;
        destinationlist.add(d);
      }
      destinationlist.sort((a, b) => a.distance!.compareTo(b.distance!));
    }
  }

  Future<dynamic> showModal(BuildContext context, String text) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 50,
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(text),
              ],
            ),
          ),
        );
      },
    );
  }
}
