import 'package:flutter/material.dart';
import 'google_map.dart';

class IPShow extends StatelessWidget {
  final Map<String, dynamic> responseData;

  IPShow(this.responseData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IP Information'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildInfoItem('IP', responseData['ip']),
            _buildInfoItem('City', responseData['city']),
            _buildInfoItem('Region', responseData['region']),
            _buildInfoItem('Country', responseData['country']),
            _buildInfoItem('Address', responseData['address']),
            _buildInfoItem('Telecom', responseData['telecom']),
            _buildInfoItem('Postal', responseData['postal']),
            _buildInfoItem('Time', responseData['time']),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapScreen(
                        double.parse(responseData['address'].split(',')[0]),
                        double.parse(responseData['address'].split(',')[1]),
                      ),
                    ));
              },
              child: Text('View on Map'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String title, dynamic value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            value != null ? value.toString() : '조회 불가',
            style: TextStyle(color: value != null ? Colors.black : Colors.red),
          ),
        ],
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: IPShow(),
//   ));
// }
