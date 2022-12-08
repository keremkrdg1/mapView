// ignore_for_file: prefer_const_constructors, sort_child_properties_las, prefer_is_empty, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/get_user_data.dart';
import 'map_view_controller.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

MapViewController mvController = MapViewController();
MapController mapController = MapController();
TextEditingController controller = TextEditingController();
bool isVisible = false;

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                center: LatLng(49.580932, -105.428391),
                zoom: 3,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://mt1.google.com/vt/lyrs=m&x={x}&y={y}&z={z}",
                ),
                MarkerLayer(
                  markers: mvController.marker,
                ),
              ],
            ),
            Positioned(
              top: 15,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 50),
                height: 50,
                width: 300,
                decoration: BoxDecoration(color: Colors.white),
                child: TextField(
                  controller: controller,
                  onChanged: (value) {
                    setState(() {
                      if (value.length > 2) {
                        mvController.searchList = [];
                        mvController.searchFunc();
                        isVisible = true;
                      }
                    });
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        mvController.marker = [];
                        controller.clear();
                        setState(() {
                          isVisible = false;
                          FocusScope.of(context).unfocus();
                        });
                      },
                      icon: Icon(Icons.clear),
                    ),
                    hintText: "Search Name/Address",
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isVisible,
              child: Positioned(
                top: 65,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(color: Colors.white),
                  width: 300,
                  height: 250,
                  child: ListView.builder(
                    itemCount: mvController.searchList.length > 0
                        ? mvController.searchList.length
                        : user.length,
                    itemBuilder: (context, index) {
                      var item = mvController.searchList.length > 0
                          ? mvController.searchList[index]
                          : user[index];
                      return Card(
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              mapController.move(item.latLng, 16);
                              mvController.marker = [
                                Marker(
                                  point: item.latLng,
                                  builder: (context) {
                                    return IconButton(
                                      onPressed: () {
                                        mvController.showModal(context,
                                            "${item.displayName} / ${item.address}");
                                      },
                                      icon: Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                        size: 35,
                                      ),
                                    );
                                  },
                                ),
                              ];
                              FocusScope.of(context).unfocus();
                              controller.text =
                                  "${item.displayName} / ${item.address}";
                              isVisible = false;
                              mvController.selectedLat = item.lat;
                              mvController.selectedLng = item.lng;
                            });
                          },
                          title: Text(item.displayName),
                          subtitle: Text(item.address),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              right: 15,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.blue,
                ),
                child: TextButton(
                  child: Text(
                    "X",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      mvController.selectedLat = null;
                      mvController.selectedLng = null;
                      mvController.marker = [];
                      controller.text = "";
                    });
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 75,
              right: 15,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.blue,
                ),
                child: TextButton(
                  child: Text(
                    "ALL",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    mapController.move(LatLng(49.580932, -105.428391), 2);
                    setState(() {
                      mvController.marker = [
                        for (int i = 0; i < user.length; i++)
                          Marker(
                            point: user[i].latLng,
                            builder: (context) {
                              return IconButton(
                                onPressed: () {
                                  mvController.showModal(context,
                                      "${user[i].displayName} / ${user[i].address}");
                                },
                                icon: Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 35,
                                ),
                              );
                            },
                          ),
                      ];
                    });
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 135,
              right: 15,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.blue,
                ),
                child: TextButton(
                  child: Text(
                    "5",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      mvController.distanceCalculation();
                      mapController.move(
                          mvController.destinationlist[0].latLng, 5);
                      mvController.marker = [
                        for (int i = 0; i <= 5; i++)
                          Marker(
                            point: mvController.destinationlist[i].latLng,
                            builder: (context) {
                              return IconButton(
                                onPressed: () {
                                  mvController.showModal(context,
                                      "${mvController.destinationlist[i].displayName} / ${mvController.destinationlist[i].address}");
                                },
                                icon: Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 35,
                                ),
                              );
                            },
                          ),
                      ];
                    });
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              left: 15,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.blue,
                ),
                child: TextButton(
                  child: Text(
                    "TSP",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
