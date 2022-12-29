import 'package:cloud_firestore/cloud_firestore.dart';

class Client {
  final String firstName;
  final String lastName;
  final String email;
  final String address;

  Client({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      firstName: json['firstName'],
      lastName: (json['lastName']),
      email: json['email'],
      address: json['address'],
    );
  }

  toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'address': address,
    };
  }
}
