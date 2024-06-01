import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ip_map_instance/screen/Two_IP_info.dart';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: InputTwoIP(),
  ));
}

class InputTwoIP extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<InputTwoIP> {
  String External_ipAddress = 'Loading...';
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  Future<void> _externalIpAddress() async {
    try {
      var response = await http.get(Uri.parse('https://api.ip.pe.kr/json'));

      if (response.statusCode == 200) {
        final jsonData = response.body;
        final ipData = json.decode(jsonData);
        setState(() {
          this.External_ipAddress = ipData['ip'];
          print('my external ip address : ${this.External_ipAddress}');
        });
      } else {
        throw Exception('Failed to load IP address');
      }
    } catch (e) {
      setState(() {
        this.External_ipAddress = 'Error: $e';
      });
    }
  }

  Future<Map<String, dynamic>> _fetchIPInfo(String ip) async {
    String serverUrl = 'http://localhost:4242/search?ip=${ip}';
    var response = await http.get(Uri.parse(serverUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load IP info');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Two IP Addresses'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller1,
                    decoration: InputDecoration(
                      labelText: 'Enter the external IP address...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () async {
                    await _externalIpAddress();
                    controller1.text = External_ipAddress;
                  },
                  child: Text('My external ip'),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller2,
                    decoration: InputDecoration(
                      labelText: 'Enter the external IP address...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () async {
                    await _externalIpAddress();
                    controller2.text = External_ipAddress;
                  },
                  child: Text('My external ip'),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                String ip1 = controller1.text;
                String ip2 = controller2.text;

                try {
                  Map<String, dynamic> responseData1 = await _fetchIPInfo(ip1);
                  Map<String, dynamic> responseData2 = await _fetchIPInfo(ip2);

                  print('Response for IP1: $responseData1');
                  print('Response for IP2: $responseData2');

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TwoIPInfo(responseData1, responseData2),
                    ),
                  );
                } catch (e) {
                  print('Error: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to fetch IP information.'),
                    ),
                  );
                }
              },
              child: Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}
