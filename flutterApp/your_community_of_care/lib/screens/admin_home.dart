import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login_and_database/screens/admin_screens/manage_clients.dart';
import 'package:login_and_database/screens/admin_screens/upload_agreements.dart';
import 'package:login_and_database/screens/employee_screens/view_agreements.dart';
import 'package:login_and_database/screens/employee_screens/view_charting.dart';
import 'package:login_and_database/screens/welcome.dart';
import 'package:login_and_database/services/auth.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

import 'admin_screens/manage_staff.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  static String id = 'admin_home_screen';

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreen();
}

class _AdminHomeScreen extends State<AdminHomeScreen> {
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  final AuthService _auth = AuthService();

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      minimumSize: const Size(170, 35),
      maximumSize: const Size(170, 35),
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
                            height: 45.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.blue[400],
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Center(
                                child: Text(
                                  '1pm Dec 20 Michael Buble - John Connor ',
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
                            height: 45.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.blue[400],
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Center(
                                child: Text(
                                  '3:30pm Dec 20 Michael Buble - Sarah Connor',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //Text('Selected date: $_selectedDate'),
                          //Text('Selected date count: $_dateCount'),
                          //Text('Selected range: $_range'),
                          //Text('Selected ranges count: $_rangeCount')
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: SfDateRangePicker(
                      onSelectionChanged: _onSelectionChanged,
                      selectionMode: DateRangePickerSelectionMode.range,
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
            height: 5.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, ManageStaff.id);
                },
                style: style,
                child: Text('Manage Staff'),
              ),
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, ManageClients.id);
                },
                style: style,
                child: Text('Manage Clients'),
              ),
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                onPressed: () {
                  if (kIsWeb) {
                    Navigator.pushNamed(context, UploadAgreements.id);
                  }
                },
                style: style,
                child: Text('Upload Agreements'),
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
            ],
          ),
        ],
      ),
    ));
  }
}
