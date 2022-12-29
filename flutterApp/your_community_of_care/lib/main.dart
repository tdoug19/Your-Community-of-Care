import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_and_database/screens/admin_home.dart';
import 'package:login_and_database/screens/admin_screens/manage_clients.dart';
import 'package:login_and_database/screens/admin_screens/upload_agreements.dart';
import 'package:login_and_database/screens/employee_home.dart';
import 'package:login_and_database/screens/employee_screens/edit_charting.dart';
import 'package:login_and_database/screens/employee_screens/view_charting.dart';
import 'package:login_and_database/screens/welcome.dart';
import 'app.dart';
import 'firebase_options.dart';
import 'screens/admin_screens/manage_staff.dart';
import 'screens/login.dart';
import 'screens/welcome.dart';

// TODO(codelab user): Get API key
const clientId = 'YOUR_CLIENT_ID';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        Login.id: (context) => Login(),
        AdminHomeScreen.id: (context) => AdminHomeScreen(),
        EmployeeHomeScreen.id: (context) => EmployeeHomeScreen(),
        EmployeeHomeScreen.id: (context) => EmployeeHomeScreen(),
        ManageStaff.id: (context) => ManageStaff(),
        ManageClients.id: (context) => ManageClients(),
        UploadAgreements.id: (context) => UploadAgreements(),
        ViewCharting.id: (context) => ViewCharting(),
        EditCharting.id: (context) => EditCharting(),
      },
    );
  }
}
