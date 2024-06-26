import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../api/api.dart';
import 'IP_Display.dart';
import '../../models/IP_Info.dart';
import 'dart:io';

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
      home: Scaffold(
        appBar: AppBar(
          title: Text('내 IP 주소'), // Title of the app bar
          leading: IconButton(
            icon: Icon(Icons.arrow_back), // Icon for navigating back
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Myippage(), // Display the InputTwoIP widget
      ),
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
  late IpInfo responseData; // 검색어를 입력 받기 위한 컨트롤러

  @override
  void initState() {
    super.initState();
    _getIpAddress();
    _externalIpAddress();
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
      var response = await http.get(Uri.parse('https://api.ip.pe.kr/json'));

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

  Future<void> _sendSearchQuery(String query) async {
    try {
      IpInfo response = await ApiHelper.sendIP(query);
      setState(() {
        responseData = response;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print('Button clicked: Check my IP Info');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IPShow(responseData),
                  ),
                );
              },
              child: Text('내 외부 IP 주소 정보 확인하기'),
            ),
          ],
        ),
      ),
    );
  }
}
