import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_and_database/models/charting_model.dart';
import 'package:login_and_database/services/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Charting');

class ChartingCrud {
  static Future<Response> addChartingData({
    required String firstName,
    required String lastName,
    required String visitDate,
    required String chart_data,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer =
        _Collection.doc('4ck0cZwGz2N5bBxQ23CU');

    Map<String, dynamic> data = <String, dynamic>{
      "firstName": firstName,
      "lastName": lastName,
      "visitDate": visitDate,
      "chart_data": chart_data,
    };

    var result = await documentReferencer.update({
      'charting_data': FieldValue.arrayUnion([data])
    }).then((value) {
      response.code = 200;
      response.message = "Successfully Added";
    }, onError: (e) {
      response.code = 500;
      response.message = e.toString();
    });

    return response;
  }

  static Future<List> getChartingData({
    required String firstName,
    required String lastName,
  }) async {
    List<Charting> _chartingTotal = [];
    List<Charting> _charting = [];

    CollectionReference charting = _firestore.collection('Charting');

    DocumentSnapshot snapshot =
        await charting.doc('4ck0cZwGz2N5bBxQ23CU').get();

    var data = snapshot.data() as Map;

    var chartingData = data['charting_data'] as List<dynamic>;

    /* hydrate all the data into the _charting structure */
    chartingData.forEach((chartData) {
      _chartingTotal.add(Charting.fromJson(chartData));
    });

    _chartingTotal.forEach((e) {
      if (e.firstName == firstName && e.lastName == lastName) {
        _charting.add(e);
      }
    });
    return _charting;
  }

  static Future<List> getChartingDataOnDate({
    required String firstName,
    required String lastName,
    required String visitDate,
  }) async {
    List<Charting> _chartingTotal = [];
    List<Charting> _charting = [];

    CollectionReference charting = _firestore.collection('Charting');

    DocumentSnapshot snapshot =
        await charting.doc('4ck0cZwGz2N5bBxQ23CU').get();

    var data = snapshot.data() as Map;

    var chartingData = data['charting_data'] as List<dynamic>;

    /* hydrate all the data into the _charting structure */
    chartingData.forEach((chartData) {
      _chartingTotal.add(Charting.fromJson(chartData));
    });

    _chartingTotal.forEach((e) {
      if (e.firstName == firstName &&
          e.lastName == lastName &&
          e.visitDate == visitDate) {
        _charting.add(e);
      }
    });
    return _charting;
  }
}
