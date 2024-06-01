import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

class MapDistance extends StatefulWidget {
  final double lat1;
  final double lon1;
  final double lat2;
  final double lon2;

  MapDistance(this.lat1, this.lon1, this.lat2, this.lon2);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapDistance> {
  GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _setMapFitToTour());
  }

  @override
  Widget build(BuildContext context) {
    LatLng location1 = LatLng(widget.lat1, widget.lon1);
    LatLng location2 = LatLng(widget.lat2, widget.lon2);

    return Scaffold(
      appBar: AppBar(
        title: Text('Map with Distance'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(
                (widget.lat1 + widget.lat2) / 2,
                (widget.lon1 + widget.lon2) / 2,
              ),
              zoom: 10.0,
            ),
            onMapCreated: (controller) {
              setState(() {
                mapController = controller;
                _setMapFitToTour();
              });
            },
            markers: {
              Marker(markerId: MarkerId('Location1'), position: location1),
              Marker(markerId: MarkerId('Location2'), position: location2),
            },
            polylines: {
              Polyline(
                polylineId: PolylineId('line1'),
                points: [location1, location2],
                color: Colors.blue,
                width: 5,
              ),
            },
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Text(
                'Distance: ${calculateDistance(widget.lat1, widget.lon1, widget.lat2, widget.lon2).toStringAsFixed(2)} km',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _setMapFitToTour() {
    if (mapController == null) return;

    LatLngBounds bounds;
    LatLng location1 = LatLng(widget.lat1, widget.lon1);
    LatLng location2 = LatLng(widget.lat2, widget.lon2);

    if (widget.lat1 > widget.lat2 && widget.lon1 > widget.lon2) {
      bounds = LatLngBounds(southwest: location2, northeast: location1);
    } else if (widget.lat1 > widget.lat2) {
      bounds = LatLngBounds(
          southwest: LatLng(widget.lat2, widget.lon1),
          northeast: LatLng(widget.lat1, widget.lon2));
    } else if (widget.lon1 > widget.lon2) {
      bounds = LatLngBounds(
          southwest: LatLng(widget.lat1, widget.lon2),
          northeast: LatLng(widget.lat2, widget.lon1));
    } else {
      bounds = LatLngBounds(southwest: location1, northeast: location2);
    }

    mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // Radius of the Earth in kilometers

    double dLat = _degreesToRadians(lat2 - lat1);
    double dLon = _degreesToRadians(lon2 - lon1);

    double a = pow(sin(dLat / 2), 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            pow(sin(dLon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }
}
