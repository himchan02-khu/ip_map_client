import 'package:flutter/material.dart';
import './Google_Map.dart';

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
                if (responseData['address'] != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapScreen(
                        double.parse(responseData['address'].split(',')[0]),
                        double.parse(responseData['address'].split(',')[1]),
                      ),
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('오류'),
                        content: Text('위치 조회가 되지 않는 IP입니다'),
                        actions: [
                          TextButton(
                            child: Text('확인'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
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
