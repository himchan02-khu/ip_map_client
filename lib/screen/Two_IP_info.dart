import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './MapDistance.dart';

class TwoIPInfo extends StatefulWidget {
  final Map<String, dynamic> responseData1;
  final Map<String, dynamic> responseData2;

  TwoIPInfo(this.responseData1, this.responseData2);

  @override
  _TwoIPInfoState createState() => _TwoIPInfoState();
}

class _TwoIPInfoState extends State<TwoIPInfo> {
  String koreanAddress1 = '조회 불가';
  String koreanAddress2 = '조회 불가';

  @override
  void initState() {
    super.initState();
    fetchKoreanAddresses();
  }

  Future<void> fetchKoreanAddresses() async {
    if (widget.responseData1['locate'] != null) {
      String address1 =
          await fetchKoreanAddress(widget.responseData1['locate']);
      setState(() {
        koreanAddress1 = address1;
      });
    }

    if (widget.responseData2['locate'] != null) {
      String address2 =
          await fetchKoreanAddress(widget.responseData2['locate']);
      setState(() {
        koreanAddress2 = address2;
      });
    }
  }

  Future<String> fetchKoreanAddress(String locate) async {
    final apiKey = 'AIzaSyA70KzHVrptd0-9lUE2uynA8CdKA2wqUpw';
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$locate&language=ko&key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['results'].isNotEmpty) {
        return data['results'][0]['formatted_address'];
      } else {
        return '주소를 찾을 수 없습니다';
      }
    } else {
      throw Exception('Failed to load address');
    }
  }

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
                _buildInfoItem('IP', widget.responseData1['ip']),
                _buildInfoItem('City', widget.responseData1['city']),
                _buildInfoItem('Region', widget.responseData1['region']),
                _buildInfoItem('Country', widget.responseData1['country']),
                _buildInfoItem('Locate', widget.responseData1['locate']),
                _buildInfoItem('Telecom', widget.responseData1['telecom']),
                _buildInfoItem('Postal', widget.responseData1['postal']),
                _buildInfoItem('Time', widget.responseData1['time']),
                _buildInfoItem('Address', koreanAddress1),
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
                _buildInfoItem('IP', widget.responseData2['ip']),
                _buildInfoItem('City', widget.responseData2['city']),
                _buildInfoItem('Region', widget.responseData2['region']),
                _buildInfoItem('Country', widget.responseData2['country']),
                _buildInfoItem('Locate', widget.responseData2['locate']),
                _buildInfoItem('Telecom', widget.responseData2['telecom']),
                _buildInfoItem('Postal', widget.responseData2['postal']),
                _buildInfoItem('Time', widget.responseData2['time']),
                _buildInfoItem('Address', koreanAddress2),
              ],
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (widget.responseData1['locate'] != null &&
                  widget.responseData2['locate'] != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapDistance(
                      double.parse(
                          widget.responseData1['locate'].split(',')[0]),
                      double.parse(
                          widget.responseData1['locate'].split(',')[1]),
                      double.parse(
                          widget.responseData2['locate'].split(',')[0]),
                      double.parse(
                          widget.responseData2['locate'].split(',')[1]),
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
