import 'package:flutter/material.dart';
import 'package:login_and_database/models/charting_model.dart';
import 'package:login_and_database/services/charting_crud.dart';

class EditCharting extends StatefulWidget {
  const EditCharting({super.key});

  static String id = 'edit_charting_screen';

  @override
  State<EditCharting> createState() => _EditChartingState();
}

class _EditChartingState extends State<EditCharting> {
  final _client_first_name = TextEditingController();
  final _client_last_name = TextEditingController();
  final _client_visit_date = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _chartData = "";

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
            _chartData = _charting.last.visitDate +
                '\n' +
                '\n' +
                _charting.last.chart_data;
          });
        }
      },
      style: style,
      child: const Text('Search Date'),
    );

    final saveEditedChartData = ElevatedButton(
      onPressed: () async {},
      style: style,
      child: const Text('Save'),
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
                    const SizedBox(height: 20.0),
                    searchOnDateButton,
                    const SizedBox(height: 20.0),
                  ],
                ),
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
                  child: Text('$_chartData'),
                ),
              ),
              const SizedBox(height: 20.0),
              saveEditedChartData,
            ]),
          ),
        ),
      ),
    );
  }
}
