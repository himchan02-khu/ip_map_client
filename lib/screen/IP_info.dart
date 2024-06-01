import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './Google_Map.dart';
import '../api/api.dart'; // api.dart 파일을 가져옵니다

class IPShow extends StatelessWidget {
  final Map<String, dynamic> responseData;

  IPShow(this.responseData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IP Information'),
      ),
      body: FutureBuilder<String>(
        future: responseData['locate'] != null
            ? ApiHelper.fetchAddress(
                double.parse(responseData['locate'].split(',')[0]),
                double.parse(responseData['locate'].split(',')[1]),
              )
            : Future.value(null),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('주소를 가져오는데 실패했습니다'));
          } else {
            String koreanAddress = snapshot.data ?? '조회 불가';
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildInfoItem('IP', responseData['ip']),
                  _buildInfoItem('City', responseData['city']),
                  _buildInfoItem('Region', responseData['region']),
                  _buildInfoItem('Country', responseData['country']),
                  _buildInfoItem('Locate', responseData['locate']),
                  _buildInfoItem('Telecom', responseData['telecom']),
                  _buildInfoItem('Postal', responseData['postal']),
                  _buildInfoItem('Time', responseData['time']),
                  _buildInfoItem('Address', koreanAddress),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (responseData['locate'] != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapScreen(
                              double.parse(
                                  responseData['locate'].split(',')[0]),
                              double.parse(
                                  responseData['locate'].split(',')[1]),
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
