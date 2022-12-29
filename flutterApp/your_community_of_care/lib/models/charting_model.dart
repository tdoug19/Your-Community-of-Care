import 'package:cloud_firestore/cloud_firestore.dart';

class Charting {
  final String firstName;
  final String lastName;
  final String visitDate;
  final String chart_data;

  Charting(
      {required this.firstName,
      required this.lastName,
      required this.visitDate,
      required this.chart_data});

  factory Charting.fromJson(Map<String, dynamic> json) {
    return Charting(
      firstName: json['firstName'],
      lastName: (json['lastName']),
      visitDate: json['visitDate'],
      chart_data: json['chart_data'],
    );
  }

  toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'visitDate': visitDate,
      'chart_data': chart_data,
    };
  }
}
