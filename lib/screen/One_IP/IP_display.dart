import 'package:flutter/material.dart';
import 'Google_Map.dart';
import '../../api/api.dart';
import '../../models/IP_Info.dart';

class IPShow extends StatelessWidget {
  final IpInfo ipInfo;

  IPShow(this.ipInfo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IP Information'),
      ),
      body: FutureBuilder<String>(
        future: ipInfo.locate != '조회 불가'
            ? ApiHelper.fetchAddress(
                double.parse(ipInfo.locate.split(',')[0]),
                double.parse(ipInfo.locate.split(',')[1]),
              )
            : Future.value('조회 불가'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('주소를 가져오는데 실패했습니다'));
          } else {
            String detailAddress = snapshot.data ?? '조회 불가';
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildInfoItem('IP', ipInfo.ip),
                  _buildInfoItem('City', ipInfo.city),
                  _buildInfoItem('Region', ipInfo.region),
                  _buildInfoItem('Country', ipInfo.country),
                  _buildInfoItem('Locate', ipInfo.locate),
                  _buildInfoItem('Telecom', ipInfo.telecom),
                  _buildInfoItem('Postal', ipInfo.postal),
                  _buildInfoItem('Time', ipInfo.time),
                  _buildInfoItem('Detail Address', detailAddress),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      print('Button clicked: View on Map');
                      if (ipInfo.locate != '조회 불가') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapScreen(
                              double.parse(ipInfo.locate.split(',')[0]),
                              double.parse(ipInfo.locate.split(',')[1]),
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
            );
          }
        },
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
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                value != null ? value.toString() : '조회 불가',
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
