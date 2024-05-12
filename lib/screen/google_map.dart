import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final double lat;
  final double lon;

  const MapScreen(this.lat, this.lon);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IP on Google Maps'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.lat, widget.lon), // Use lat and lon from widget
          zoom: 14.0,
        ),
        markers: {
          Marker(
            markerId: MarkerId('targetLocation'),
            position:
                LatLng(widget.lat, widget.lon), // Use lat and lon from widget
            infoWindow: InfoWindow(title: 'Target Location'),
          ),
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MapScreen(37.7749, -122.4194), // Example latitude and longitude
  ));
}
