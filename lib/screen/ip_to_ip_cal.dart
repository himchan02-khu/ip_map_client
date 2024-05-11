import '../widget/back_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

void main() {
  runApp(IPdistance());
}

class IPdistance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Distance Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DistanceCalculator(),
    );
  }
}

class DistanceCalculator extends StatefulWidget {
  @override
  _DistanceCalculatorState createState() => _DistanceCalculatorState();
}

class _DistanceCalculatorState extends State<DistanceCalculator> {
  LatLng location1 = LatLng(37.7749, -122.4194); // Default location 1
  LatLng location2 = LatLng(34.0522, -118.2437); // Default location 2
  GoogleMapController? mapController;
  TextEditingController latitudeController1 = TextEditingController();
  TextEditingController longitudeController1 = TextEditingController();
  TextEditingController latitudeController2 = TextEditingController();
  TextEditingController longitudeController2 = TextEditingController();
  double distance = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Distance Calculator'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    37.7749, -122.4194), // Initial position (San Francisco)
                zoom: 10.0,
              ),
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller;
                });
              },
              markers: {
                Marker(markerId: MarkerId('Location 1'), position: location1),
                Marker(markerId: MarkerId('Location 2'), position: location2),
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Location 1'),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: latitudeController1,
                        decoration: InputDecoration(labelText: 'Latitude'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: TextField(
                        controller: longitudeController1,
                        decoration: InputDecoration(labelText: 'Longitude'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                Text('Location 2'),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: latitudeController2,
                        decoration: InputDecoration(labelText: 'Latitude'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: TextField(
                        controller: longitudeController2,
                        decoration: InputDecoration(labelText: 'Longitude'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      location1 = LatLng(double.parse(latitudeController1.text),
                          double.parse(longitudeController1.text));
                      location2 = LatLng(double.parse(latitudeController2.text),
                          double.parse(longitudeController2.text));
                      calculateDistance();
                      mapController?.animateCamera(CameraUpdate.newLatLngBounds(
                        LatLngBounds(
                            southwest: location1, northeast: location2),
                        100.0,
                      ));
                    });
                  },
                  child: Text('Update Locations'),
                ),
                SizedBox(height: 8.0),
                Text('Distance: ${distance.toStringAsFixed(2)} km'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void calculateDistance() {
    const double earthRadius = 6371; // Radius of the Earth in kilometers

    // Convert latitude and longitude from degrees to radians
    double lat1Rad = _degreesToRadians(location1.latitude);
    double lon1Rad = _degreesToRadians(location1.longitude);
    double lat2Rad = _degreesToRadians(location2.latitude);
    double lon2Rad = _degreesToRadians(location2.longitude);

    // Calculate differences in latitude and longitude
    double dLat = lat2Rad - lat1Rad;
    double dLon = lon2Rad - lon1Rad;

    // Calculate the distance using the Haversine formula
    double a = pow(sin(dLat / 2), 2) +
        cos(lat1Rad) * cos(lat2Rad) * pow(sin(dLon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    setState(() {
      distance = earthRadius * c;
    });
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }
}
