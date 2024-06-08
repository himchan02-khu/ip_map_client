import 'package:flutter/material.dart';
import '../../models/IP_Info.dart';
import './MapDistance.dart';

class TwoIPInfo extends StatelessWidget {
  final IpInfo ipInfo1;
  final IpInfo ipInfo2;

  TwoIPInfo(this.ipInfo1, this.ipInfo2);

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
                Text('IP Info 1',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                _buildInfoItem('IP', ipInfo1.ip),
                _buildInfoItem('City', ipInfo1.city),
                _buildInfoItem('Region', ipInfo1.region),
                _buildInfoItem('Country', ipInfo1.country),
                _buildInfoItem('Locate', ipInfo1.locate),
                _buildInfoItem('Telecom', ipInfo1.telecom),
                _buildInfoItem('Postal', ipInfo1.postal),
                _buildInfoItem('Time', ipInfo1.time),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('IP Info 2',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                _buildInfoItem('IP', ipInfo2.ip),
                _buildInfoItem('City', ipInfo2.city),
                _buildInfoItem('Region', ipInfo2.region),
                _buildInfoItem('Country', ipInfo2.country),
                _buildInfoItem('Locate', ipInfo2.locate),
                _buildInfoItem('Telecom', ipInfo2.telecom),
                _buildInfoItem('Postal', ipInfo2.postal),
                _buildInfoItem('Time', ipInfo2.time),
              ],
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (ipInfo1.locate != null && ipInfo2.locate != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapDistance(
                      double.parse(ipInfo1.locate.split(',')[0]),
                      double.parse(ipInfo1.locate.split(',')[1]),
                      double.parse(ipInfo2.locate.split(',')[0]),
                      double.parse(ipInfo2.locate.split(',')[1]),
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
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                value != null ? value.toString() : '조회 불가',
                style:
                    TextStyle(color: value != null ? Colors.black : Colors.red),
                textAlign: TextAlign.right,
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
