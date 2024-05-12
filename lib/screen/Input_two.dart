import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
      // Make an HTTP GET request to a service that provides the public IP address
      var response = await http.get(Uri.parse('https://api.ip.pe.kr/json'));

      // Parse the JSON response
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
                    // Add functionality to get 'My external ip'
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
                    // Add functionality to get 'My external ip'
                    controller2.text = External_ipAddress;
                  },
                  child: Text('My external ip'),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Add functionality for moving to the next step
              },
              child: Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}
