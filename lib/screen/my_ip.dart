import 'dart:io';
import 'package:flutter/material.dart';
import '../main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widget/back_button.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Previous Page'), // Title of the app bar
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back), // Icon for navigating back
            onPressed: () {
              // Navigation logic to go back
            },
          ),
        ],
      ),
      body: My_ip(), // Display the InputTwoIP widget
    ),
  ));
}

class My_ip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'In/External IP Check',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Myippage(),
    );
  }
}

class Myippage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Myippage> {
  String Internal_ipAddress = 'Loading...';
  String External_ipAddress = 'Loading...';

  @override
  void initState() {
    super.initState();
    _getIpAddress();
    _externalIpAddress();
  }

  void _sendSearchQuery(String query) async {
    String serverUrl = 'http://localhost:4242/search?ip=${query}';

    var response = await http.get(Uri.parse(serverUrl));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  Future<void> _getIpAddress() async {
    try {
      List<NetworkInterface> interfaces = await NetworkInterface.list(
        includeLoopback: false,
        type: InternetAddressType.IPv4,
      );

      if (interfaces.isNotEmpty) {
        setState(() {
          this.Internal_ipAddress = interfaces.first.addresses.first.address;
          _sendSearchQuery(this.Internal_ipAddress);
          print('my internal ip address : ${this.Internal_ipAddress}');
        });
      } else {
        setState(() {
          this.Internal_ipAddress = 'IP address not found';
        });
      }
    } catch (e) {
      setState(() {
        this.Internal_ipAddress = 'Error: $e';
      });
    }
  }

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
          _sendSearchQuery(this.External_ipAddress);
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
      // appBar: AppBar(
      //   title: Text('IP Check'),
      //   // leading: const BackBtn(),
      //   // backgroundColor: Colors.transparent,
      //   // flexibleSpace: const SizedBox.shrink(),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Device Internal IP Address:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              Internal_ipAddress,
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Device External IP Address:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              External_ipAddress,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
