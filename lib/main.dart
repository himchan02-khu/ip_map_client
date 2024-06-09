import 'package:flutter/material.dart';
import 'package:ip_map_instance/models/IP_Info.dart';
import 'screen/One_IP/IP_Display.dart';
import 'screen/One_IP/My_IP.dart';
import 'screen/Two_IP/Input_two.dart';
import 'api/api.dart'; // Import the ApiHelper class

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
  late IpInfo responseData; // 검색어를 입력 받기 위한 컨트롤러

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
      appBar: AppBar(
        title: Text('IP_map'),
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
                    print('Button Pressed : IP Search');
                    String query = _searchController.text;
                    await _sendSearchQuery(query);
                    // print('responseData : ${responseData.}');
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
