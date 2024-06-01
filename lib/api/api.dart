import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiHelper {
  static const String _apiKey = 'AIzaSyA70KzHVrptd0-9lUE2uynA8CdKA2wqUpw';

  static Future<String> fetchAddress(double lat, double lon) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lon&language=ko&key=$_apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['results'].isNotEmpty) {
        return data['results'][0]['formatted_address'];
      } else {
        return '주소를 찾을 수 없습니다';
      }
    } else {
      throw Exception('Failed to load address');
    }
  }

  static Future<Map<String, String>> fetchAddresses(
      double lat1, double lon1, double lat2, double lon2) async {
    final address1 = await fetchAddress(lat1, lon1);
    final address2 = await fetchAddress(lat2, lon2);
    return {'address1': address1, 'address2': address2};
  }
}
