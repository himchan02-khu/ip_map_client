import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ip_map_instance/screen/IP_show.dart';
import 'screen/my_ip.dart';
import 'screen/Input_two.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IP_map_distance_추힘찬',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _searchController = TextEditingController();
  late Map<String, dynamic> responseData = {}; // 검색어를 입력 받기 위한 컨트롤러

  Future<void> _sendSearchQuery(String query) async {
    String serverUrl = 'http://localhost:4242/search?ip=${query}';

    var response = await http.get(Uri.parse(serverUrl));

    print('serverUrl: ${serverUrl}');

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    setState(() {
      responseData = jsonDecode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IP_map_distance'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset('assets/images/logo.jpeg'),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'IP 주소를 입력하세요...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    String query = _searchController.text;
                    await _sendSearchQuery(query);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => IPShow(responseData)));
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                // Add your function to check IP address here
                print('Button clicked: Check my IP address');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => My_ip()),
                );
              },
              child: Text('Check my IP address'),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                // Add your function to check IP address here
                print('Button clicked: address to address');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InputTwoIP()),
                );
              },
              child: Text('Check address to address'),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'By Himchan02',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
