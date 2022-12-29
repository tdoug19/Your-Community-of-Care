import 'package:flutter/material.dart';
import 'package:login_and_database/screens/admin_screens/add_new_staff.dart';
import 'package:login_and_database/screens/admin_screens/add_new_client.dart';

class ManageStaff extends StatelessWidget {
  const ManageStaff({super.key});

  static String id = 'manage_staff_screen';

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      minimumSize: const Size(150, 40),
      maximumSize: const Size(150, 40),
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
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddNewStaff()));
                },
                style: style,
                child: Text('Add New'),
              ),
              SizedBox(
                height: 50.0,
              ),
              ElevatedButton(
                onPressed: () {},
                style: style,
                child: Text('Edit Existing'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
