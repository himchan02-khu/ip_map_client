import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'screen/my_ip.dart';
import 'screen/ip_to_ip_cal.dart';
import 'screen/Input_two.dart';

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

class MyHomePage extends StatelessWidget {
  TextEditingController _searchController =
      TextEditingController(); // 검색어를 입력 받기 위한 컨트롤러

  void _sendSearchQuery(String query) async {
    String serverUrl = 'http://localhost:4242/search?ip=${query}';

    var response = await http.get(Uri.parse(serverUrl));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
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
                  onPressed: () {
                    String query = _searchController.text;
                    _sendSearchQuery(query);
                    // Navigator.push(
                    //   context, MaterialPageRoute(builder: (context => MapScreen(response)));
                    // )
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
