import 'package:cloud_firestore/cloud_firestore.dart';

class GeoLocationData {
  GeoPoint? point;

  GeoLocationData({required this.point});

  GeoLocationData.fromMap(Map<String, dynamic> map) {
    point = map['location'];
  }
}
