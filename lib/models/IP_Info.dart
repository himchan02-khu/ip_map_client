class IpInfo {
  final String ip;
  final String city;
  final String region;
  final String country;
  final String locate;
  final String telecom;
  final String postal;
  final String time;

  IpInfo({
    required this.ip,
    required this.city,
    required this.region,
    required this.country,
    required this.locate,
    required this.telecom,
    required this.postal,
    required this.time,
  });

  factory IpInfo.fromJson(Map<String, dynamic> json) {
    return IpInfo(
      ip: json['ip'] ?? '조회 불가',
      city: json['city'] ?? '조회 불가',
      region: json['region'] ?? '조회 불가',
      country: json['country'] ?? '조회 불가',
      locate: json['locate'] ?? '조회 불가',
      telecom: json['telecom'] ?? '조회 불가',
      postal: json['postal'] ?? '조회 불가',
      time: json['time'] ?? '조회 불가',
    );
  }
}
