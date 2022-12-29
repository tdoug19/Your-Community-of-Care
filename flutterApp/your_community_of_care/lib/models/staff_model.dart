import 'package:cloud_firestore/cloud_firestore.dart';

class Staff {
  final String firstName;
  final String lastName;
  final String email;
  final String? id;

  Staff({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.id,
  });

  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      firstName: json['firstName'],
      lastName: (json['lastName']),
      email: json['email'],
      id: json['id'],
    );
  }

  toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'id': id,
    };
  }
}
