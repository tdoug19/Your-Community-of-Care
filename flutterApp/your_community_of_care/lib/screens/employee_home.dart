import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart' hide Colors;
import 'package:login_and_database/models/client_visit.dart';
import 'package:login_and_database/screens/employee_screens/add_charting.dart';
import 'package:login_and_database/screens/employee_screens/edit_charting.dart';
import 'package:login_and_database/screens/employee_screens/view_agreements.dart';
import 'package:login_and_database/screens/employee_screens/view_charting.dart';
import 'package:login_and_database/screens/welcome.dart';
import 'package:login_and_database/services/CalendarClient.dart';
import 'package:login_and_database/services/auth.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class EmployeeHomeScreen extends StatefulWidget {
  const EmployeeHomeScreen({super.key});

  static String id = 'employee_home_screen';

  @override
  State<EmployeeHomeScreen> createState() => _EmployeeHomeScreen();
}

class _EmployeeHomeScreen extends State<EmployeeHomeScreen> {
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  String _appt1 = "";
  String _appt2 = "";

  CalendarClient _calendarClient = new CalendarClient();

  final AuthService _auth = AuthService();

  Future<void> _onSelectionChanged(
      DateRangePickerSelectionChangedArgs args) async {
    DateTime dt = args.value;

    EventDateTime edt = new EventDateTime(
      date: dt,
    );
    _selectedDate = args.value.toString();

    Future<List<ClientMeeting>> clientAppointments =
        _calendarClient.getCalender(dt);
    clientAppointments.then((value) {
      setState(() {
        _appt1 = value.first.hour.toString() +
            ':' +
            value.first.minute.toString() +
            ' ' +
            value.first.description;
        _appt2 = value.last.hour.toString() +
            ':' +
            value.last.minute.toString() +
            ' ' +
            value.last.description;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      minimumSize: const Size(180, 40),
      maximumSize: const Size(180, 40),
    );

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
          title: const Text('Your Community of Care'),
          backgroundColor: Colors.blue[400],
          actions: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.person),
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
              label: const Text('Logout'),
              onPressed: () {
                _auth.signOut();
                Navigator.pushNamed(context, WelcomeScreen.id);
              },
            )
          ]),
      backgroundColor: Colors.blue[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                      width: 100.0,
                      height: 250.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        //color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 50.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.blue[400],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Center(
                                  child: Text(
                                    '$_appt1',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              height: 50.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.blue[400],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Center(
                                  child: Text(
                                    '$_appt2',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //Text('$_selectedDate'),
                            //Text('Selected date count: $_dateCount'),
                            //Text('Selected range: $_range'),
                            //Text('Selected ranges count: $_rangeCount')
                          ],
                        ),
                      )),
                ),
                const SizedBox(
                  width: 25.0,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: SfDateRangePicker(
                      onSelectionChanged: _onSelectionChanged,
                      selectionMode: DateRangePickerSelectionMode.single,
                      initialSelectedRange: PickerDateRange(
                        DateTime.now().subtract(const Duration(days: 4)),
                        DateTime.now().add(const Duration(days: 3)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddCharting()));
                },
                style: style,
                child: Text('Add Charting'),
              ),
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ViewCharting()));
                },
                style: style,
                child: Text('View Charting'),
              ),
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => EditCharting()));
                },
                style: style,
                child: Text('Edit Charting'),
              ),
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ViewAgreements()));
                },
                style: style,
                child: Text('View Agreements'),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
