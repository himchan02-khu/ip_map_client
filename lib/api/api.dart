import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/IP_Info.dart'; // IpInfo 클래스 파일 경로를 import합니다.

class ApiHelper {
  static Future<IpInfo> sendIP(String ip) async {
    String serverUrl = 'http://localhost:4242/search?ip=${ip}';
    var response = await http.get(Uri.parse(serverUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      print('IpInfo : ${responseData}');
      return IpInfo.fromJson(responseData);
    } else {
      throw Exception('Failed to load IP info');
    }
  }

  static Future<String> fetchAddress(double lat, double lon) async {
    final url = 'http://localhost:4242/address?lat=$lat&lon=$lon';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Detail Address : ${data}');
      return data['address'];
    } else {
      throw Exception('Failed to load address');
    }
  }

  static Future<Map<String, String>> fetchAddresses(
      double lat1, double lon1, double lat2, double lon2) async {
    final url = Uri.parse(
        'http://localhost:4242/addresses?lat1=$lat1&lon1=$lon1&lat2=$lat2&lon2=$lon2');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Detail Address1 : ${data['address1']}');
      print('Detail Address2 : ${data['address2']}');
      return {'address1': data['address1'], 'address2': data['address2']};
    } else {
      throw Exception('Failed to load addresses');
    }
  }
}
