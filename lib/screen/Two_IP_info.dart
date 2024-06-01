import 'package:flutter/material.dart';
import './MapDistance.dart';

class TwoIPInfo extends StatelessWidget {
  final Map<String, dynamic> responseData1;
  final Map<String, dynamic> responseData2;

  TwoIPInfo(this.responseData1, this.responseData2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IP Information'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('IP Address 1',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                _buildInfoItem('IP', responseData1['ip']),
                _buildInfoItem('City', responseData1['city']),
                _buildInfoItem('Region', responseData1['region']),
                _buildInfoItem('Country', responseData1['country']),
                _buildInfoItem('Address', responseData1['address']),
                _buildInfoItem('Telecom', responseData1['telecom']),
                _buildInfoItem('Postal', responseData1['postal']),
                _buildInfoItem('Time', responseData1['time']),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('IP Address 2',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                _buildInfoItem('IP', responseData2['ip']),
                _buildInfoItem('City', responseData2['city']),
                _buildInfoItem('Region', responseData2['region']),
                _buildInfoItem('Country', responseData2['country']),
                _buildInfoItem('Address', responseData2['address']),
                _buildInfoItem('Telecom', responseData2['telecom']),
                _buildInfoItem('Postal', responseData2['postal']),
                _buildInfoItem('Time', responseData2['time']),
              ],
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (responseData1['address'] != null &&
                  responseData2['address'] != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapDistance(
                      double.parse(responseData1['address'].split(',')[0]),
                      double.parse(responseData1['address'].split(',')[1]),
                      double.parse(responseData2['address'].split(',')[0]),
                      double.parse(responseData2['address'].split(',')[1]),
                    ),
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('오류'),
                      content: Text('거리를 표시할 수 없습니다'),
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
            child: Text('두 IP의 거리보기'),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String title, dynamic value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
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
