// import 'package:google_maps_flutter/google_maps_flutter.dart';

// 주소값 두개 줬을 때 핑 찍어주는 함수
// 주소값 4개 줬을 때 거리 나타내는 함수 (dest, origin - 현재위치)
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen(lat, lon);
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Variables to store latitude and longitude values
  double latitude = 0.0;
  double longitude = 0.0;

  // Function to fetch latitude and longitude values from the server
  Future<void> fetchLocation() async {
    // Replace this with your server endpoint to fetch latitude and longitude
    // Example: final response = await http.get('https://your-server.com/location');
    // Parse the response to extract latitude and longitude values
    // Example: final data = json.decode(response.body);
    // Example: final double lat = data['latitude'];
    // Example: final double lng = data['longitude'];
    // Update the state with the received latitude and longitude values
    print("touch MapScreen");

    setState(() {
      latitude = 37.7749; // Example latitude value
      longitude = -122.4194; // Example longitude value
    });
  }

  @override
  void initState() {
    super.initState();
    fetchLocation(); // Fetch location when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Example'),
      ),
      body: latitude != 0.0 && longitude != 0.0
          ? GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(latitude, longitude),
                zoom: 14.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('currentLocation'),
                  position: LatLng(latitude, longitude),
                  infoWindow: InfoWindow(title: 'Current Location'),
                ),
              },
            )
          : Center(
              child:
                  CircularProgressIndicator(), // Show loading indicator while fetching location
            ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MapScreen(0.0, 0.0),
  ));
}
