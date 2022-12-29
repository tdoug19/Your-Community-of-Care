import 'package:flutter/material.dart';
import 'package:login_and_database/services/charting_crud.dart';

class AddCharting extends StatefulWidget {
  const AddCharting({super.key});

  @override
  State<AddCharting> createState() => _AddChartingState();
}

class _AddChartingState extends State<AddCharting> {
  final _charting_first_name = TextEditingController();
  final _charting_last_name = TextEditingController();
  final _charting_visit_date = TextEditingController();
  final _charting_data = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      minimumSize: const Size(150, 40),
      maximumSize: const Size(150, 40),
    );

    final firstNameField = TextFormField(
        controller: _charting_first_name,
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
        controller: _charting_last_name,
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

    final chartingVisitDateField = TextFormField(
        controller: _charting_visit_date,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Charting Date",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final chartingDataField = TextFormField(
        controller: _charting_data,
        autofocus: false,
        maxLines: null,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Charting Data",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final saveButton = ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          var response = await ChartingCrud.addChartingData(
            firstName: _charting_first_name.text,
            lastName: _charting_last_name.text,
            visitDate: _charting_visit_date.text,
            chart_data: _charting_data.text,
          );
          if (response.code != 200) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(response.message.toString()),
                  );
                });
          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(response.message.toString()),
                  );
                });
          }
        }
      },
      style: style,
      child: Text('Add'),
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
            child: Icon(
              color: Colors.white,
              Icons.arrow_back_ios,
            ),
          ),
        ),
        backgroundColor: Colors.blue[100],
        body: Center(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        firstNameField,
                        const SizedBox(height: 25.0),
                        lastNameField,
                        const SizedBox(height: 25.0),
                        chartingVisitDateField,
                        const SizedBox(height: 25.0),
                        chartingDataField,
                        const SizedBox(height: 45.0),
                        saveButton,
                        const SizedBox(height: 15.0),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
