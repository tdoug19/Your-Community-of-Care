import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_and_database/services/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Client');

class ClientCrud {
  static Future<Response> addClient({
    required String firstName,
    required String lastName,
    required String email,
    required String address,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer =
        _Collection.doc('9Of9qakusxrWFuoXnuZg');

    Map<String, dynamic> data = <String, dynamic>{
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "address": address,
    };

    var result = await documentReferencer.update({
      'clients': FieldValue.arrayUnion([data])
    }).then((value) {
      response.code = 200;
      response.message = "Successfully Added";
    }, onError: (e) {
      response.code = 500;
      response.message = e.toString();
    });

    return response;
  }

  static Future<Response> updateStaff({
    required String firstName,
    required String lastName,
    required String email,
    required String address,
  }) async {
    Response response = Response();

    Map<String, dynamic> data = <String, dynamic>{
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "address": address,
    };

    return response;
  }

  static Stream<QuerySnapshot> readEmployee() {
    CollectionReference notesItemCollection = _Collection;

    return notesItemCollection.snapshots();
  }
}
