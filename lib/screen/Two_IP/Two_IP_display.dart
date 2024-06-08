import 'package:flutter/material.dart';
import '../../models/IP_Info.dart';
import '../../api/api.dart';
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
            child: _buildIPInfo(ipInfo1),
          ),
          Divider(),
          Expanded(
            child: _buildIPInfo(ipInfo2),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (ipInfo1.locate != '조회 불가' && ipInfo2.locate != '조회 불가') {
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

  Widget _buildIPInfo(IpInfo ipInfo) {
    return FutureBuilder<String>(
      future: ipInfo.locate == '조회 불가'
          ? Future.value('조회 불가')
          : ApiHelper.fetchAddress(
              double.parse(ipInfo.locate.split(',')[0]),
              double.parse(ipInfo.locate.split(',')[1]),
            ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('주소를 가져오는데 실패했습니다'));
        } else {
          String detailAddress = snapshot.data ?? '조회 불가';
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('IP Info',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              _buildInfoItem('IP', ipInfo.ip),
              _buildInfoItem('City', ipInfo.city),
              _buildInfoItem('Region', ipInfo.region),
              _buildInfoItem('Country', ipInfo.country),
              _buildInfoItem('Locate', ipInfo.locate),
              _buildInfoItem('Telecom', ipInfo.telecom),
              _buildInfoItem('Postal', ipInfo.postal),
              _buildInfoItem('Time', ipInfo.time),
              _buildInfoItem('Detail Address', detailAddress),
            ],
          );
        }
      },
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
