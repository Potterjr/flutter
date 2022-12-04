import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MyMap extends StatefulWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  late Position _position;
  late bool serviceEnabled;
  late LocationPermission permission;

  void permission_check() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location Service is disabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permission has been denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      print("Permently denied, cannot request permission");
    }
    print(Geolocator.getCurrentPosition());
    setState(() {
      _position = Geolocator.getCurrentPosition() as Position;
    });
  }

  double lat = 14.16114681;
  double lng = 101.3511717;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    permission_check();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("test map"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                _getCurrentLocation();
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Current Posisiton"),
                        content: Text(
                            "Lat : ${_position.latitude}\nLng : ${_position.longitude}"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("OK"),
                          )
                        ],
                      );
                    });
              },
              child: const Text("Get location")),
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(lat, lng),
                zoom: 15,
              ),
              layers: [
                TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                    attributionBuilder: (_) {
                      return const Text("OpenStreetMap");
                    }),
                MarkerLayerOptions(markers: [
                  Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(lat, lng),
                      builder: (ctx) => const FlutterLogo())
                ])
              ],
            ),
          )
        ],
      ),
    );
  }

  void _getCurrentLocation() {
    Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      forceAndroidLocationManager: true,
    ).then((Position position) {
      setState(() {
        _position = position;
        lat = position.latitude;
        lng = position.longitude;
      });
    }).catchError((e) {
      print(e);
    });
  }
}