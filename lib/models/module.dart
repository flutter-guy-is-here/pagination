import 'package:cloud_firestore/cloud_firestore.dart';

class Module {
  String? name;
  int? coef;
  String? year;
  int? hours;
  Timestamp? timestamp;

  Module({this.name, this.coef, this.year, this.hours});

  Module.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    coef = json['coef'];
    year = json['year'];
    hours = json['hours'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['coef'] = this.coef;
    data['year'] = this.year;
    data['hours'] = this.hours;
    data['timestamp'] = this.timestamp ?? FieldValue.serverTimestamp();
    return data;
  }
}
