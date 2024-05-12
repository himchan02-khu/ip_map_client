import '../widget/back_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

void main() {
  runApp(IPdistance(
      lat1: 37.7749, lon1: -122.4194, lat2: 34.0522, lon2: -118.2437));
}

class IPdistance extends StatelessWidget {
  final double lat1;
  final double lon1;
  final double lat2;
  final double lon2;

  const IPdistance({
    required this.lat1,
    required this.lon1,
    required this.lat2,
    required this.lon2,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Distance Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DistanceCalculator(lat1: lat1, lon1: lon1, lat2: lat2, lon2: lon2),
    );
  }
}

class DistanceCalculator extends StatefulWidget {
  final double lat1;
  final double lon1;
  final double lat2;
  final double lon2;

  const DistanceCalculator({
    required this.lat1,
    required this.lon1,
    required this.lat2,
    required this.lon2,
  });

  @override
  _DistanceCalculatorState createState() => _DistanceCalculatorState();
}

class _DistanceCalculatorState extends State<DistanceCalculator> {
  late LatLng location1;
  late LatLng location2;
  GoogleMapController? mapController;
  double distance = 0.0;

  @override
  void initState() {
    super.initState();
    location1 = LatLng(widget.lat1, widget.lon1);
    location2 = LatLng(widget.lat2, widget.lon2);
    calculateDistance();
  }

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
                target: location1, // Initial position
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
              polylines: {
                Polyline(
                  polylineId: PolylineId('Distance'),
                  points: [location1, location2],
                  color: Colors.red,
                  width: 2,
                ),
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Distance: ${distance.toStringAsFixed(2)} km',
              style: TextStyle(fontSize: 16),
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
