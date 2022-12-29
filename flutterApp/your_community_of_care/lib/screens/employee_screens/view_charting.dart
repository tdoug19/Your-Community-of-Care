import 'package:flutter/material.dart';
import 'package:login_and_database/models/charting_model.dart';
import 'package:login_and_database/services/charting_crud.dart';

class ViewCharting extends StatefulWidget {
  const ViewCharting({super.key});

  static String id = 'view_charting_screen';

  @override
  State<ViewCharting> createState() => _ViewChartingState();
}

class _ViewChartingState extends State<ViewCharting> {
  final _client_first_name = TextEditingController();
  final _client_last_name = TextEditingController();
  final _client_visit_date = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _chartData1 = "";
  String _chartData2 = "";
  String _chartData3 = "";

  getChartData() async {}

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      minimumSize: const Size(150, 40),
      maximumSize: const Size(150, 40),
    );
    final firstNameField = TextFormField(
        controller: _client_first_name,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Client First Name",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final lastNameField = TextFormField(
        controller: _client_last_name,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Client Last Name",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final visitDateField = TextFormField(
        controller: _client_visit_date,
        autofocus: false,
        validator: (value) {},
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Visit Date",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final searchButton = ElevatedButton(
      onPressed: () async {
        List<Charting> _charting = [];
        if (_formKey.currentState!.validate()) {
          var _charting = await ChartingCrud.getChartingData(
            firstName: _client_first_name.text,
            lastName: _client_last_name.text,
          );

          setState(() {
            var length = _charting.length;
            if (length > 3) {
              length = 3;
            }

            switch (length) {
              case 0:
                _chartData1 = "No Chart Data";
                break;

              case 1:
                _chartData1 = _charting.last.visitDate +
                    '\n' +
                    '\n' +
                    _charting.last.chart_data;
                break;

              case 2:
                _chartData1 = _charting.last.visitDate +
                    '\n' +
                    '\n' +
                    _charting.last.chart_data;
                _chartData2 =
                    _charting.elementAt(_charting.length - 2).visitDate +
                        '\n' +
                        '\n' +
                        _charting.elementAt(_charting.length - 2).chart_data;
                break;

              case 3:
                _chartData1 = _charting.last.visitDate +
                    '\n' +
                    '\n' +
                    _charting.last.chart_data;
                _chartData2 =
                    _charting.elementAt(_charting.length - 2).visitDate +
                        '\n' +
                        '\n' +
                        _charting.elementAt(_charting.length - 2).chart_data;
                _chartData3 =
                    _charting.elementAt(_charting.length - 3).visitDate +
                        '\n' +
                        '\n' +
                        _charting.elementAt(_charting.length - 3).chart_data;
                break;
            }
          });
        }
      },
      style: style,
      child: const Text('Search Charting'),
    );

    final searchOnDateButton = ElevatedButton(
      onPressed: () async {
        List<Charting> _charting = [];
        if (_formKey.currentState!.validate()) {
          var _charting = await ChartingCrud.getChartingDataOnDate(
            firstName: _client_first_name.text,
            lastName: _client_last_name.text,
            visitDate: _client_visit_date.text,
          );

          setState(() {
            _chartData1 = _charting.last.visitDate +
                '\n' +
                '\n' +
                _charting.last.chart_data;
            _chartData2 = "";
            _chartData3 = "";
          });
        }
      },
      style: style,
      child: const Text('Search Date'),
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Your Community of Care'),
          backgroundColor: Colors.blue[400],
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              color: Colors.white,
              Icons.arrow_back_ios,
            ),
          ),
        ),
        backgroundColor: Colors.blue[100],
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    firstNameField,
                    const SizedBox(height: 20.0),
                    lastNameField,
                    const SizedBox(height: 20.0),
                    visitDateField,
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        searchButton,
                        SizedBox(
                          width: 10.0,
                        ),
                        searchOnDateButton,
                      ],
                    ),
                    const SizedBox(height: 15.0),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: 450.0,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                        height: 140.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('$_chartData1'),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        height: 140.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('$_chartData2'),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        height: 140.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('$_chartData3'),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
