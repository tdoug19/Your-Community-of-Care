import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_and_database/services/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Staff');

class StaffCrud {
  static Future<Response> addStaff({
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer =
        _Collection.doc('9WK1MxGmxObKVZHaQ0Yk');

    Map<String, dynamic> data = <String, dynamic>{
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
    };

    var result = await documentReferencer.update({
      'staff_members': FieldValue.arrayUnion([data])
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
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully updated Employee";
      print('Successfully Td UPdated');
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Stream<QuerySnapshot> readEmployee() {
    CollectionReference notesItemCollection = _Collection;

    return notesItemCollection.snapshots();
  }
}
